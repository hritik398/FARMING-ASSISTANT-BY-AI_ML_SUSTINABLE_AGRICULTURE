import 'dart:io';
static tfl.Interpreter? _interpreter;
static List<String> _labels = [];
static ImageProcessor? _imageProcessor;
static const _inputSize = 224; // adapt to your model


static Future<void> load() async {
_interpreter ??= await tfl.Interpreter.fromAsset('assets/models/model.tflite');
final raw = await rootBundle.loadString('assets/models/labels.txt');
_labels = raw.split('\n').where((e) => e.trim().isNotEmpty).toList();


_imageProcessor = ImageProcessorBuilder()
.add(ResizeOp(_inputSize, _inputSize, ResizeMethod.NEAREST_NEIGHBOUR))
.build();
}


static Future<Map<String, dynamic>> runOnImage(File file) async {
if (_interpreter == null) await load();


// decode and preprocess
final img = (await ImageProcessorBuilder.decodeImageFromList(await file.readAsBytes()))!;
final inputImage = _imageProcessor!.process(img);


// Convert to tensor
final inputTensor = TensorImage.fromImage(inputImage);


// Prepare output buffer (1 x N)
final outShapes = _interpreter!.getOutputTensor(0).shape;
final outType = _interpreter!.getOutputTensor(0).type;
final output = TensorBuffer.createFixedSize(outShapes, outType);


// run
_interpreter!.run(inputTensor.buffer, output.buffer);


// get scores
final scores = output.getDoubleList();
int maxIdx = 0;
double maxScore = -1;
for (int i = 0; i < scores.length; i++) {
if (scores[i] > maxScore) {
maxScore = scores[i];
maxIdx = i;
}
}


final label = (maxIdx < _labels.length) ? _labels[maxIdx] : 'Unknown';


return {
'label': label,
'confidence': maxScore,
'scores': scores,
};
}
}
