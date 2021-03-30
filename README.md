# Autoware (Architecture Proposal)

![autoware](https://user-images.githubusercontent.com/8327598/69472442-cca50b00-0ded-11ea-9da0-9e2302aa1061.png)

A meta-repository for the Autoware architecture proposal feasibility study created by Tier IV. For more details about the architecture itself, please read this [overview](/design/Overview.md).

> **WARNING**: All source code relating to this meta-repository is solely intended to demonstrate a potential new architecture for Autoware, and should not be used to autonomously drive a real car!
> 
> **NOTE**: The features within the [AutowareArchitectureProposal.iv repository](https://github.com/tier4/AutowareArchitectureProposal.iv) are planned to be merged into [Autoware.Auto](https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto).

# Installation Guide

## Requirements

### Hardware

- x86 CPU (8 cores)
- 16GB RAM
- Nvidia GPU (4GB RAM) \*optional
  - Although not required to run basic functionality, a GPU is mandatory in order to run the following components:
    - lidar_apollo_instance_segmentation
    - traffic_light_ssd_fine_detector
    - cnn_classifier

> Note that the specifications above are the minimum requirements. Performance will be improved with more cores, RAM and a higher-spec graphics card.

### Software

 - Ubuntu 18.04
 - Nvidia driver
 
## Review licenses 
The following software will be installed during the installation process, so please confirm their licenses first before proceeding.

- [CUDA 10.2](https://docs.nvidia.com/cuda/eula/index.html)
- [cuDNN 7](https://docs.nvidia.com/deeplearning/sdk/cudnn-sla/index.html)
- [osqp](https://github.com/oxfordcontrol/osqp/blob/master/LICENSE)
- [ROS Melodic](https://github.com/ros/ros/blob/noetic-devel/LICENSE)
- [TensorRT 7](https://docs.nvidia.com/deeplearning/sdk/tensorrt-sla/index.html)
 
## How to setup

> If the CUDA or TensorRT frameworks have already been installed, we strongly recommend uninstalling them first!

1. Install ROS (steps taken from the [ROS wiki installation guide](http://wiki.ros.org/melodic/Installation/Ubuntu))

```sh
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
sudo apt update
```

2. Set up the Autoware repository

```sh
sudo apt install -y python3-vcstool
git clone git@github.com:tier4/AutowareArchitectureProposal.git
cd AutowareArchitectureProposal
mkdir -p src
vcs import src < autoware.proj.repos
```

3. Run the setup script (this step will install CUDA, cuDNN 7, osqp and TensorRT 7)

```sh
./setup_ubuntu18.04.sh
```

4. Build the source code

```sh
source ~/.bashrc
colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release --catkin-skip-building-tests
```

## How to configure

### Set hardware configuration

Prepare launch and vehicle_description files according to the sensor configuration of your hardware.  
The following files are provided as samples:

- [sensing.launch](https://github.com/tier4/autoware_launcher.universe/blob/master/sensing_launch/launch/sensing.launch)
- [lexus_description](https://github.com/tier4/lexus_description.iv.universe)

## How to run

### Supported Simulations

![sim](https://user-images.githubusercontent.com/8327598/79709776-0bd47b00-82fe-11ea-872e-d94ef25bc3bf.png)

### Quick Start

#### Rosbag

1. Download sample pointcloud and vector maps from [here](https://drive.google.com/open?id=1ovrJcFS5CZ2H51D8xVWNtEvj_oiXW-zk).
2. Download a sample rosbag from [here](https://drive.google.com/open?id=1BFcNjIBUVKwupPByATYczv2X4qZtdAeD).
3. Open a terminal and launch Autoware

```sh
cd AutowareArchitectureProposal
source install/setup.bash
roslaunch autoware_launch logging_simulator.launch map_path:=[path] vehicle_model:=lexus sensor_model:=aip_xx1 rosbag:=true
```

> Note that the absolute path is required for `map_path` above.

4. Open a second terminal and play the rosbag file

```sh
rosbag play --clock [rosbag file] -r 0.2
```

##### Note

- Sample map and rosbag: © 2020 Tier IV, Inc.
  - Due to privacy concerns, the rosbag does not contain image data.
  - Consequently, traffic light recognition functionality cannot be tested with this sample rosbag. Furthermore object detection accuracy is decreased.

#### Planning Simulator

1. Download sample pointcloud and vector maps from [here](https://drive.google.com/open?id=197kgRfSomZzaSbRrjWTx614le2qN-oxx).
2. Open a terminal and launch Autoware

```sh
cd AutowareArchitectureProposal
source install/setup.bash
roslaunch autoware_launch planning_simulator.launch map_path:=[path] vehicle_model:=lexus sensor_model:=aip_xx1
```

> Note that the absolute path is required for `map_path` above.

3. Set an initial pose for the ego vehicle
4. Set a goal pose  for the ego vehicle
5. Engage the ego vehicle.
   - a. Open the [autoware_web_controller](http://localhost:8085/autoware_web_controller/index.html) in a browser.
   - b. Click the `Engage` button.

##### Note

- Sample map: © 2020 Tier IV, Inc.

#### Running the source code With Autoware.Auto
- We are planning to propose this new architecture and reference implementation for inclusion in [Autoware.Auto](https://gitlab.com/autowarefoundation/autoware.auto/AutowareAuto).
- In the meantime, [ros_bridge](https://github.com/ros2/ros1_bridge) should be used if you wish to try out this code with existing Autoware.Auto modules.
  - Until the architectures are aligned, message type conversions are required to enable communication between the Autoware.Auto and AutowareArchitectureProposal modules and need to be added manually.

To set up Autoware.Auto, please follow the instruction instructions [here](https://autowarefoundation.gitlab.io/autoware.auto/AutowareAuto/installation.html).
To set up ros_bridge, please follow the instructions [here](https://github.com/ros2/ros1_bridge#prerequisites).

#### Detailed tutorial instructions

See [here](./docs/SimulationTutorial.md). for more information.

## References

### Videos

- [Scenario demo](https://youtu.be/kn2bIU_g0oY)
- [Obstacle avoidance in the same lane](https://youtu.be/s_4fBDixFJc)
- [Obstacle avoidance by lane change](https://youtu.be/SCIceXW9sqM)
- [Object recognition](https://youtu.be/uhhMIxe1zxQ)
- [Auto parking](https://youtu.be/e9R0F0ZJbWE)
- [360° FOV perception(Camera Lidar Fuison)](https://youtu.be/whzx-2RkVBA)
- [Robustness of localization](https://youtu.be/ydPxWB2jVnM)

### Credits

- [Neural Network Weight Files](./docs/Credits.md)
