import os
import torch
from mlp_mixer_pytorch import MLPMixer
import numpy as np
import cv2
from glob import glob
from sklearn.utils import shuffle
from sklearn.model_selection import train_test_split
import tensorflow as tf
import keras
import scipy.io
from keras.callbacks import ModelCheckpoint, CSVLogger, ReduceLROnPlateau, EarlyStopping
from keras.layers import *
from keras.models import Model
from torchvision import transforms

path = '/Users/arpanmukhopadhyay/Documents/EEG topics/sleep-edfx-toolbox-master/markers/0/image1.mat'
hp = {}
hp['classes'] = ['0','1','2','3','4','5']

def transform_mat (path):
    filename  = path[-1]
    className = path[-2]
    data = scipy.io.loadmat(path)
    eog = np.array(data['eog'])
    fpz = np.array(data['fpz'])
    pz = np.array(data['pz'])
    
    image_np = np.stack((eog, pz, fpz), axis=-1)
    numpy_to_tensor = transforms.ToTensor()
    tensor_array = numpy_to_tensor(image_np)
    class_name = path.split("/")[-2]
    print(class_name)
    class_idx = hp["classes"].index(class_name)
    print(class_idx)
    class_idx = np.array(class_idx, dtype=np.int32)
    print(class_idx)

transform_mat(path)