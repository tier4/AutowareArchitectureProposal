Detection
=====
# Role
Prediction in Object Recognition estimate objects' intention. Intentions are represented as objects' future trajectories with covariance. The Planning module makes a decision and plans a future ego-motion based on the results of predicted objects.

## Input

| Input       | Data Type | Topic |
|-|-|-|
| Dynamic Objects       | `autoware_perception_msgs::DynamicObjectArray`|/perception/object_recognition/tracking/objects|
|Map|`autoware_lanelet2_msgs::MapBin`|/map/vector_map|
|TF  | `tf2_msgs::TFMessage`|/tf|

## Output

| Output       | Data Type| Output Componenet | TF Frame | Topic|
|----|-|-|-|-|
|Dynamic Objects|`autoware_perception_msgs::DynamicObjectArray`|Planning| `map`|/perception/object_recognition/objects|

## Design
This is our sample implementation for the Tracking module.
![msg](/img/ObjectPredictionDesign.png)


## Requirement in Output
Designated objects' property in autoware_perception_msgs::DynamicObject needs to be filled in the Prediction module before passing to the Planning component.

![msg](/img/ObjectPredictionRequirement.png)


| Property  | Definition |Data Type                                 | Parent Data Type|
|-------------|--|-------------------------------------------|----|
| predicted_path      | Predicted furuter paths for an object.|`autoware_perception_msgs::PredictedPath[]	`|`autoware_perception_msgs::State` |