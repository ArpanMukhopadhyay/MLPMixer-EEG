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
from torch.utils.data import TensorDataset
import torch.optim as optim
from torch.utils.data import DataLoader
import torch.nn as nn
import torch.optim as optim

def transform_mat (path):
    data = scipy.io.loadmat(path)
    eog = np.array(data['eog'])
    fpz = np.array(data['fpz'])
    pz = np.array(data['pz'])
    image_np = np.stack((eog, pz, fpz), axis=-1)
    # tensor_array = torch.tensor(image_np)
    return image_np

# if path:
#     print(path)
# class_name = path.split("/")[-1]
# print(class_name)
path = '/Users/arpanmukhopadhyay/Documents/EEG topics/sleep-edfx-toolbox-master/markers'

def load_data(path, split=0.1):
    images = shuffle(glob(os.path.join(path, "*", "*.mat")))
    split_size = int(len(images) * split)
    train_x, valid_x = train_test_split(images, test_size=split_size, random_state=42)
    train_x, test_x = train_test_split(train_x, test_size=split_size, random_state=42)
    return train_x, valid_x, test_x

train_x, valid_x, test_x = load_data(path)

def ReturnClassCount(data):
    class_count = {'0':0, '1':0, '2':0, '3':0, '4':0, '5':0}
    for ind in range(0,len(data)):
        class_count[data[ind].split("/")[-2]] += 1
    return class_count

# print(ReturnClassCount(train_x))
# print(ReturnClassCount(test_x))
# print(ReturnClassCount(valid_x))

train_y = []
valid_y = []
test_y = []

def change(arr,labels):
    for i in range(len(arr)):
        labels.append(int(arr[i].split("/")[-2]))
        arr[i] = transform_mat(arr[i])

change(valid_x,valid_y)
change(test_x,test_y)
change(train_x,train_y)
train_x = np.array(train_x)
test_x = np.array(test_x)
valid_x = np.array(valid_x)

train_x_tensor = torch.tensor(train_x, dtype=torch.float32)
train_x_tensor = train_x_tensor.permute(0, 3, 1, 2)

train_y_tensor = torch.tensor(train_y)

test_x_tensor = torch.tensor(test_x, dtype=torch.float32)
test_x_tensor = test_x_tensor.permute(0, 3, 1, 2)

test_y_tensor = torch.tensor(test_y)

valid_x_tensor = torch.tensor(valid_x, dtype=torch.float32)
valid_x_tensor = valid_x_tensor.permute(0, 3, 1, 2)

valid_y_tensor = torch.tensor(valid_y)

# print(train_x_tensor.dtype)
# print(train_y_tensor.dtype)

# print(train_x_tensor.shape)
# print(f"Train: {len(train_x)} - Valid: {len(valid_x)} - Test: {len(test_x)}")

train_dataset = TensorDataset(train_x_tensor, train_y_tensor)
train_dataloader = DataLoader(train_dataset, batch_size=64, shuffle=True)

val_dataset = TensorDataset(valid_x_tensor, valid_y_tensor)
val_dataloader = DataLoader(val_dataset, batch_size=32)

test_dataset = TensorDataset(test_x_tensor, test_y_tensor)
test_dataloader = DataLoader(test_dataset, batch_size=32)

model = MLPMixer(
    image_size = (50, 60),
    channels = 3,
    patch_size = 5,
    dim = 512,
    depth = 12,
    num_classes = 6
)
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(model.parameters(), lr=0.01)

num_epochs = 5
for epoch in range(num_epochs):
    print(epoch)
    model.train()
    train_loss = 0.0
    train_correct = 0
    train_total = 0
    progress_train = len(train_dataloader)
    for inputs, labels in train_dataloader:
        progress_train -= 1
        print(progress_train)
        optimizer.zero_grad()
        outputs = model(inputs)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        train_loss += loss.item() * inputs.size(0)
        # Update training accuracy
        _, predicted = torch.max(outputs, dim=1)
        train_correct += (predicted == labels).sum().item()
        train_total += labels.size(0)
    
    train_loss /= len(train_dataloader.dataset)
    train_accuracy = train_correct / len(train_dataloader.dataset)
    
    # Step 6: Validation
    model.eval()
    val_loss = 0.0
    val_correct = 0
    with torch.no_grad():
        progress_val = len(val_dataloader)
        total_correct = 0
        total_samples = 0
        for inputs, labels in val_dataloader:
            outputs = model(inputs)
            progress_val -= 1
            print(progress_val)
            _, predicted = torch.max(outputs, 1)
            total_samples += labels.size(0)
            total_correct += (predicted == labels).sum().item()
            
            val_loss += loss.item()
    val_loss /= len(val_dataloader.dataset)
    val_accuracy = total_correct / len(val_dataloader.dataset)

    print(f"Epoch [{epoch+1}/{num_epochs}], Train Loss: {train_loss:.4f}, Train Accuracy: {train_accuracy:.4f}, "
          f"Val Loss: {val_loss:.4f}, Val Accuracy: {val_accuracy:.4f}")

# img = torch.randn(1, 3, 50, 60)
# print(img.shape)
# print(img.dtype)
# # pred = model(img)
# # print(pred)

# # model.summary() # (1, 1000)
# # print(pred)
# # for n in test_x:
# #     pred = model(test_x)
# #     print(pred)