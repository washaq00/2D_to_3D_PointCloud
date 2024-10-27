## REPRODUCTION OF THE Training/evaluating the network

### Prerequisites  
If you want to run the code inside of the docker container, then we recommend to pull the docker image directly from the tensorflow official profile on the dockerhub, as it has already tensorflow and nvidia libraries installed and it support CUDA parallel computing.


### Dataset  
The dataset (8.8GB) can be downloaded by running the command
```
wget https://cmu.box.com/shared/static/s4lkm5ej7sh4px72vesr17b1gxam4hgy.gz
```
After downloading, run `tar -zxf s4lkm5ej7sh4px72vesr17b1gxam4hgy.gz` under the main directory of the repository. The files will be extracted to the `data` directory.  

This file includes:
- Train/test split files (from [Perspective Transformer Nets](https://github.com/xcyan/nips16_PTN))
- Input RGB images (from [Perspective Transformer Nets](https://github.com/xcyan/nips16_PTN))
- Pre-rendered depth images for training
- Ground-truth point clouds of the test split (densified to 100K points)


### Running the code  
There are 4 scripts prepared:
- Pretraining stage: `scripts/pretrain.sh`:
  - --model - define the name for the model to be saved
  - --lr - you can adjust the learning rate
  - --toIt - define the number of iterations 
- Training with joint 2D optimization: `scripts/train.sh`
  - --model - define the name for the model to be saved
  - --load - define the name of the checkpoint from the pretraining stage
  - --lr - you can adjust the learning rate
  - --fromIt and --toIt are not meant to be changed
- Evaluating on the test set: `scripts/evaluate.sh`
 probably the most important part of this code, as you can base on the the results/checkpoints from the training stage and it will affect on final calculations. We suggest to monitor results of training by uploading summary files to the collab and extract them on the diagrams. Find the optimized checkpoint and define it in the script. In most cases neural networks has the best perfomance in the first 4000 epochs. Evaulated point clouds might be visualised with matlab libraries.
  with flag:
    --load - model/checkpoint
- Computing the error metrics: `scripts/compute.sh` - script comptues Earth Mover's distance from ground truth model to the predicted cloud and in the opposite direction.

The list of optional arguments can be found by executing `python3 train.py --help`. The default training settings in this released code is slightly different from the paper but optimizes the networks better.
  

Run all of them one by one with a command: `scripts/run-pretrain.sh && scripts/run-finetune.sh && scripts/run-evaluate.sh && scripts/run-compute-error.sh` 

Checkpoints are stored in `models_${GROUP}`, summaries are stored in `summary_${GROUP}`, and evaluated point clouds are stored in `results_${GROUP}`.  







