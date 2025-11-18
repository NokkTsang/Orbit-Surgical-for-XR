# Human Teleoperation Guide for Orbit-Surgical

This guide covers how to run human-controlled surgical robotics scenes in the orbit-surgical framework with Isaac Sim 4.1.0 and Isaac Lab 1.0.0.

Supported input devices:
- **Keyboard** (currently implemented)
- **Meta Quest 3 Controller** (VR streaming - future implementation)
- **SpaceMouse** (3D input device - already supported)
- **Gamepad** (already supported)

## Prerequisites

- Isaac Sim 4.1.0
- Isaac Lab 1.0.0
- All dependencies installed (see main README for setup instructions)

## Running Teleoperation Scenes

All teleoperation scenes use the same script with different task names and input devices. The general command format is:

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task <TASK_NAME> --num_envs 1 --teleop_device <DEVICE>
```

### First-Time Simulation Setup

When you first run a teleoperation scene, Isaac Sim will prompt you to select simulation options:

1. **Simulation Backend**: Select **Fabric GPU**
   - This enables GPU-accelerated physics simulation (fastest option)
   - Required for orbit-surgical tasks configured with GPU physics
   - Other options: USD (slowest), Fabric CPU (slower than GPU)

2. **Enable reset simulation on stop**: Leave **UNCHECKED**
   - Allows you to pause/resume without losing progress
   - You can manually reset anytime by pressing **L** key

### Available Input Devices

- `keyboard` - Keyboard controls (default)
- `spacemouse` - 3D SpaceMouse device
- `gamepad` - Game controller/gamepad
- `quest3` - Meta Quest 3 VR controllers (future implementation)

### Available Keyboard-Controlled Tasks

#### 1. Block Lifting Task (Single PSM Arm)
**Task Name:** `Isaac-Lift-Block-PSM-IK-Rel-v0`

Pick up a surgical block using a single PSM (Patient Side Manipulator) arm.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Lift-Block-PSM-IK-Rel-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Control the PSM arm to grasp the block and lift it to the target position.

---

#### 2. Needle Lifting Task (Single PSM Arm)
**Task Name:** `Isaac-Lift-Needle-PSM-IK-Rel-v0`

Pick up a surgical needle using a single PSM arm.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Lift-Needle-PSM-IK-Rel-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Control the PSM arm to grasp the needle and lift it.

---

#### 3. PSM Reaching Task (Single PSM Arm)
**Task Name:** `Isaac-Reach-PSM-v0`

Move the PSM arm to reach target positions without grasping.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Reach-PSM-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Navigate the end-effector to reach specified target poses.

**Note:** This task does not support gripper control (no grasping).

---

#### 4. STAR Reaching Task (Single STAR Robot)
**Task Name:** `Isaac-Reach-STAR-v0`

Move the STAR robot arm to reach target positions.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Reach-STAR-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Control the STAR robot to reach target end-effector poses.

**Note:** This task does not support gripper control.

---

#### 5. Dual PSM Reaching Task (Two PSM Arms)
**Task Name:** `Isaac-Reach-Dual-PSM-v0`

Control two PSM arms simultaneously to reach target positions.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Reach-Dual-PSM-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Coordinate both PSM arms to reach their respective target poses.

**Note:** Uses dual-arm keyboard controls (see Dual-Arm Controls section below).

---

#### 6. Dual STAR Reaching Task (Two STAR Robots)
**Task Name:** `Isaac-Reach-Dual-STAR-v0`

Control two STAR robot arms simultaneously.

```bash
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Reach-Dual-STAR-v0 --num_envs 1 --teleop_device keyboard
```

**Objective:** Coordinate both STAR robots to reach their target poses.

**Note:** Uses dual-arm keyboard controls.

---

## Keyboard Controls

### Single-Arm Controls

When controlling a single robot arm (PSM or STAR), use these keys:

| Key | Action |
|-----|--------|
| **W/S** | Move arm forward/backward (X-axis) |
| **A/D** | Move arm left/right (Y-axis) |
| **Q/E** | Move arm up/down (Z-axis) |
| **Z/X** | Rotate around X-axis |
| **T/G** | Rotate around Y-axis |
| **C/V** | Rotate around Z-axis |
| **K** | Toggle gripper (open/close) |
| **L** | Reset environment |

**Note:** Gripper control (K) is disabled for "Reach" tasks.

---

### Dual-Arm Controls

When controlling dual arms, the keyboard is divided between two arms:

#### Arm 1 Controls
| Key | Action |
|-----|--------|
| **W/S** | Move forward/backward (X-axis) |
| **A/D** | Move left/right (Y-axis) |
| **Q/E** | Move up/down (Z-axis) |
| **Z/X** | Rotate around X-axis |
| **T/G** | Rotate around Y-axis |
| **C/V** | Rotate around Z-axis |
| **K** | Toggle gripper (open/close) |

#### Arm 2 Controls
| Key | Action |
|-----|--------|
| **I/K** | Move forward/backward (X-axis) |
| **J/L** | Move left/right (Y-axis) |
| **U/O** | Move up/down (Z-axis) |
| **N/M** | Rotate around X-axis |
| **Y/H** | Rotate around Y-axis |
| **B/,** | Rotate around Z-axis |
| **P** | Toggle gripper (open/close) |

---

## Display Settings

### Resolution

The simulation window is configured to run at 1920x1080 resolution for better visual clarity. This is set automatically in the teleoperation script.

To adjust the window size, you can modify the resolution settings in:
`source/standalone/environments/teleoperation/teleop_se3_agent.py`

Look for these lines:
```python
carb.settings.get_settings().set("/app/window/width", 1920)
carb.settings.get_settings().set("/app/window/height", 1080)
```

---

## Tips for Keyboard Control

1. **Smooth Movements**: The default sensitivity is 1.0. You can adjust it with the `--sensitivity` parameter:
   ```bash
   ./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py --task Isaac-Lift-Block-PSM-IK-Rel-v0 --num_envs 1 --teleop_device keyboard --sensitivity 0.5
   ```

2. **Reset Environment**: Press **L** to reset the environment and start over.

3. **Gripper Operation**: 
   - Press **K** to close the gripper when positioned over the object
   - Press **K** again to open the gripper to release

4. **Coordinate System**:
   - X-axis: Forward/Backward (W/S)
   - Y-axis: Left/Right (A/D)
   - Z-axis: Up/Down (Q/E)

5. **Block Lifting Strategy**:
   - First, position the gripper above the block using Q/E (up/down) and W/S/A/D (horizontal movement)
   - Lower the gripper onto the block with E
   - Close the gripper with K
   - Lift the block with Q

---

## Troubleshooting

### Issue: Simulation window doesn't appear
- Ensure you're not running in headless mode
- Check that X11 forwarding is enabled if using SSH

### Issue: Controls not responding
- Make sure the Isaac Sim window has focus
- Check that you're using the correct keys for single vs dual arm tasks

### Issue: Low frame rate or laggy controls
- Reduce the number of environments (should be 1 for teleoperation)
- Close other applications to free up GPU memory

### Issue: Module import errors
- Ensure `conda` environment is deactivated before running
- Verify that `IsaacLab_PATH` is correctly set to version 1.0.0
- Check that all extensions are properly installed

---

## Additional Tasks

To see all available tasks in the orbit-surgical framework, run:

```bash
./run_with_isaac.sh source/standalone/environments/list_envs.py
```

This will display a table of all 127+ available environments, including both keyboard-controlled and RL tasks.

---

## System Information

- **Isaac Sim Version**: 4.1.0
- **Isaac Lab Version**: 1.0.0
- **Python Version**: 3.10 (from Isaac Sim)
- **GPU**: NVIDIA RTX 4090 (or compatible)
- **CUDA**: 11.8

---

## Meta Quest 3 VR Streaming Setup (Future Implementation)

To enable VR control with Meta Quest 3 controllers and stream the simulation to the headset, you'll need to implement the following:

### 1. Quest 3 Controller Integration

Create a new controller interface at `source/extensions/orbit.surgical.ext/orbit/surgical/ext/devices/quest3/`:

```python
# se3_quest3.py
class Se3Quest3:
    """SE(3) controller for Meta Quest 3 VR controllers."""
    
    def __init__(self, pos_sensitivity: float = 0.05, rot_sensitivity: float = 0.1):
        self.pos_sensitivity = pos_sensitivity
        self.rot_sensitivity = rot_sensitivity
        # Connect to Quest 3 via OpenXR or Oculus SDK
        
    def advance(self):
        """Read Quest 3 controller state and return delta pose and gripper command."""
        # Get controller position and rotation from Quest 3
        # Map trigger to gripper control
        # Return (delta_pose, gripper_command)
        pass
```

### 2. Modify Teleoperation Script

Update `source/standalone/environments/teleoperation/teleop_se3_agent.py` to support Quest 3:

```python
from orbit.surgical.ext.devices import Se3Quest3

# In the main() function, add:
elif args_cli.teleop_device.lower() == "quest3":
    teleop_interface = Se3Quest3(
        pos_sensitivity=0.05 * args_cli.sensitivity, 
        rot_sensitivity=0.1 * args_cli.sensitivity
    )
```

### 3. VR Streaming Setup

To stream the Isaac Sim viewport to Quest 3:

#### Option A: Using NVIDIA CloudXR
1. Install NVIDIA CloudXR SDK
2. Configure Isaac Sim to output to CloudXR server
3. Connect Quest 3 via CloudXR client app
4. Enables low-latency streaming over WiFi or USB

#### Option B: Using Virtual Desktop or ALVR
1. Install Virtual Desktop or ALVR on Quest 3
2. Stream desktop to Quest 3
3. Run Isaac Sim in windowed mode
4. Controller input via OpenXR runtime

#### Option C: Using OpenXR Native Integration
1. Install OpenXR runtime compatible with Quest 3
2. Configure Isaac Sim to use OpenXR for VR rendering
3. Direct VR output to Quest 3
4. Best performance but requires more integration work

### 4. Controller Mapping

Recommended Quest 3 controller mapping:

**Right Controller (Dominant Hand - Robot Control):**
- **Thumbstick**: XY translation of end-effector
- **Thumbstick Up/Down**: Z-axis translation (up/down)
- **Controller Position**: Direct position control (1:1 or scaled mapping)
- **Controller Rotation**: Direct orientation control
- **Trigger**: Close gripper
- **Grip Button**: Open gripper
- **A Button**: Reset environment
- **B Button**: Toggle control mode

**Left Controller (Non-dominant Hand - Camera/View):**
- **Thumbstick**: Rotate camera view
- **Trigger**: Grab and move viewport
- **X Button**: Cycle through camera angles
- **Y Button**: Toggle UI overlay

### 5. Required Dependencies

```bash
# Install OpenXR loader
pip install pyopenxr

# Install Oculus SDK (if using native integration)
# Download from Oculus/Meta developer portal

# For CloudXR (NVIDIA RTX required)
# Download CloudXR SDK from NVIDIA
```

### 6. Network Configuration for Streaming

For optimal VR streaming performance:
- **WiFi 6/6E**: 5GHz or 6GHz band, dedicated router
- **USB Link**: Quest 3 via USB-C for wired connection (Air Link alternative)
- **Latency Target**: <20ms for comfortable VR interaction
- **Bitrate**: 100-200 Mbps for high quality streaming

### 7. Testing Quest 3 Integration

Once implemented, test with:

```bash
# Connect Quest 3 via USB or ensure on same WiFi network
# Start VR streaming service (CloudXR/Virtual Desktop/ALVR)

# Run teleoperation with Quest 3
./run_with_isaac.sh source/standalone/environments/teleoperation/teleop_se3_agent.py \
    --task Isaac-Lift-Block-PSM-IK-Rel-v0 \
    --num_envs 1 \
    --teleop_device quest3
```

### 8. Implementation Checklist

- [ ] Install OpenXR runtime and Quest 3 drivers
- [ ] Create `Se3Quest3` controller class
- [ ] Implement controller state reading (position, rotation, buttons)
- [ ] Add gripper control mapping (trigger/grip buttons)
- [ ] Configure VR streaming (CloudXR/Virtual Desktop/ALVR)
- [ ] Update teleop_se3_agent.py with quest3 device option
- [ ] Test controller input latency (<50ms target)
- [ ] Calibrate position/rotation sensitivity
- [ ] Test with all surgical tasks (lift, reach, dual-arm)
- [ ] Document Quest 3 setup process

### 9. Alternative: WebXR for Quest 3 Browser

For a simpler (but potentially lower performance) approach:

1. Use Isaac Sim's Omniverse Streaming Client
2. Access via Quest 3 browser with WebXR support
3. No PC required if streaming from remote server
4. Controller input via WebXR Gamepad API

### 10. Resources

- **OpenXR Specification**: https://www.khronos.org/openxr/
- **Meta Quest Developer Hub**: https://developer.oculus.com/
- **NVIDIA CloudXR**: https://developer.nvidia.com/cloudxr-sdk
- **Isaac Sim VR Documentation**: Check NVIDIA Omniverse docs for VR support
- **ALVR (Open Source VR Streaming)**: https://github.com/alvr-org/ALVR

---

## Related Files

- Wrapper script: `run_with_isaac.sh`
- Teleoperation script: `source/standalone/environments/teleoperation/teleop_se3_agent.py`
- Device controllers: `source/extensions/orbit.surgical.ext/orbit/surgical/ext/devices/`
- Task configurations: `source/extensions/orbit.surgical.tasks/orbit/surgical/tasks/surgical/`
- Environment listing: `source/standalone/environments/list_envs.py`
