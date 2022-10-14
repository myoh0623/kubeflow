import kserve
from typing import Dict, List
import argparse
import urllib
import numpy as np
import PIL.Image as Image

class ImageTransformer(kserve.Model):
    def __init__(self, name: str, predictor_host: str):
        super().__init__(name)
        self.predictor_host = predictor_host
        labels_path="/custom_transformer/ImageNetLabels.txt"
        imagenet_labels = np.array(open(labels_path).read().splitlines())
        self.imagenet_labels = imagenet_labels
        self.IMAGE_SHAPE = (224, 224)

        self.ready = True
        
    def image_transform(self, instance) -> List:
        image_url = instance["url"]
        res = request.urlopen(image_url).read()
        image_data_rs = Image.open(BytesIO(res)).resize(self.IMAGE_SHAPE)
        image_data_rs_n = np.array(image_data_rs)/255.0
        X_data = image_data_rs_n[np.newaxis, ...].tolist()
        return X_data
        
    def preprocess(self, inputs: Dict) -> Dict:
        instance = {'instances': [self.image_transform(instance) for instance in inputs['instances']]}
        return {'instances': instance}

    def postprocess(self, model_output_data: Dict) -> Dict:
        pred = model_output_data.json()['predictions'][0]
        ppredicted_class = np.argmax(pred, axis=-1)
        predicted_class_name = self.imagenet_labels[predicted_class]
        return {"predictions" : predicted_class_name}

if __name__ == "__main__":
    parser = argparse.ArgumentParser(parents=[kserve.model_server.parser])
    
    parser.add_argument(
        "--predictor_host", help="The URL for the model predict function", required=True)
    
    parser.add_argument(
        "--model_name", help="The name that the model is served under.")
    args, _ = parser.parse_known_args()

    model = ImageTransformer(args.model_name, predictor_host=args.predictor_host)

    kserve.ModelServer(workers=1).start([model])