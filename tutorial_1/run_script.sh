#/bin/bash

##### Additional packages needed not in your docker container yet
# pip install wandb

# Unzip input image files
echo "unzip"
tar -zxf tutorial_1_inputs.tar.gz

# Make necessary directories
mkdir tutorial_1_outputs
mkdir patches

echo "Running"

# Assign variables
img_path='./tutorial_1_inputs/'
output_dir='./tutorial_1_outputs/'
n_epochs=50
save_name='tutorial_1_inputs_model'

# Run script using variables
python train_model.py $img_path $output_dir $n_epochs $save_name

# tar.gz the output directory
tar -zcvf tutorial_1_outputs.tar.gz tutorial_1_outputs

echo "DONE"
