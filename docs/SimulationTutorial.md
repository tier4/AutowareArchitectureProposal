# Simulation in Autoware

Autoware provides two types of simulation:
- rosbag-based simulation that can be used for testing/validation of the `Sensing`, `Localization` and `Perception` stacks. 
- The Planning Simulator tool which is mainly used for testing/validation of `Planning` stack by simulating traffic rules, interactions with dynamic objects and control commands to the ego vehicle.
![sim](https://user-images.githubusercontent.com/8327598/79709776-0bd47b00-82fe-11ea-872e-d94ef25bc3bf.png)

## How to use a pre-recorded rosbag file for simulation
> Assumes that [AutowareArchitectureProposal setup](https://github.com/tier4/AutowareArchitectureProposal.proj#autoware-setup) has already been completed.

1. Download sample pointcloud and vector maps from [here](https://drive.google.com/open?id=1ovrJcFS5CZ2H51D8xVWNtEvj_oiXW-zk).
2. Download a sample rosbag from [here](https://drive.google.com/open?id=1BFcNjIBUVKwupPByATYczv2X4qZtdAeD).

| Sensor                | Topic name                               |
| --------------------- | ---------------------------------------- |
| Velodyne 128 (Top)    | /sensing/velodyne/top/velodyne_packets   |
| Velodyne 16 (Right)   | /sensing/velodyne/right/velodyne_packets |
| Velodyne 16 (Left)    | /sensing/velodyne/left/velodyne_packets  |
| IMU (Tamagawa TAG300) | /sensing/imu/tamagawa/imu_raw            |
| GNSS (Ublox F9P)      | /sensing/gnss/ublox/fix_velocity         |
|                       | /sensing/gnss/ublox/nav_sat_fix          |
|                       | /sensing/gnss/ublox/navpvt               |
| CAN data              | /vehicle/status/control_mode             |
|                       | /vehicle/status/shift                    |
|                       | /vehicle/status/steering                 |
|                       | /vehicle/status/twist                    |
| ~~Camera x 7~~        | ~~/sensing/camera/camera[]/image_raw~~   |

> Note: Due to privacy concerns, image data has been removed from the rosbag file.

3. Launch Autoware in "rosbag mode".

```
source install/setup.bash
roslaunch autoware_launch logging_simulator.launch map_path:=[path]
```
> Note that an absolute path must be specified for `map_path` above.

4. Play sample rosbag.

```
rosbag play --clock -r 0.2　sample.bag
```

![rosbag_sim](https://user-images.githubusercontent.com/10920881/79726334-9381b000-8325-11ea-9ac6-ebbb29b11f14.png)

##### Note

- Sample map and rosbag: © 2020 Tier IV, Inc.

## How to use the Planning Simulator

> Assumes that [AutowareArchitectureProposal setup](https://github.com/tier4/AutowareArchitectureProposal.proj#autoware-setup) has already been completed.

1. Download sample pointcloud and vector maps from [here](https://drive.google.com/open?id=197kgRfSomZzaSbRrjWTx614le2qN-oxx) and extract the zip file.
2. Launch Autoware with Planning Simulator

```
source install/setup.bash
roslaunch autoware_launch planning_simulator.launch map_path:=[path]
```
> Note that an absolute path must be specified for `map_path` above.

![initial](https://user-images.githubusercontent.com/10920881/79816587-8b298380-83be-11ea-967c-8c45772e30f4.png)

3. Set the initial pose for the ego vehicle by clicking the `2D Pose Estimate` button in Rviz (click and hold the left-mouse button in the 3D View pane, then drag to set the direction of the pose).

![start](https://user-images.githubusercontent.com/10920881/79816595-8e247400-83be-11ea-857a-32cf096ac3dc.png)

4. Set the goal pose by clicking the `2D Nav Goal` button in Rviz (click and hold the left-mouse button in the 3D View pane, then drag to set the direction of the pose).

![goal](https://user-images.githubusercontent.com/10920881/79816596-8fee3780-83be-11ea-9ee4-caabbef3a385.png)

5. Engage the ego vehicle.
   - a. Open the [autoware_web_controller](http://localhost:8085/autoware_web_controller/index.html) in a browser.
   - b. Click the `Engage` button.

![engage](https://user-images.githubusercontent.com/10920881/79714298-4db7ee00-830b-11ea-9ac4-11e126d7a7c4.png)

### Simulate dummy obstacles

- Set the position of dummy obstacle by clicking the `2D Dummy Pedestrian` or `2D Dummy Car` buttons in Rviz.
  - These two buttons correspond to the shortcut keys `l` and `k` respectively.
  - The properties of an object (including velocity, position/orientation error etc) can be adjusted via the `Tool Properties` panel in Rviz.
  - Objects placed in the 3D View can be deleted by clicking the `Delete All Objects` button in Rviz and then clicking inside the 3D View pane.
    ![dummy](https://user-images.githubusercontent.com/10920881/79742437-c9cb2980-833d-11ea-8ad7-7c3ed1a96540.png)

### Simulate parking maneuver

Set goal in parking area.

![parking](https://user-images.githubusercontent.com/10920881/79817389-56b6c700-83c0-11ea-873b-6ec73c8a5c38.png)

##### Note

- sample map : © 2020 TierIV inc.
