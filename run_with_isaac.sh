#!/bin/bash
# Wrapper script to run orbit-surgical with Isaac Sim 4.1.0 and Isaac Lab 1.0.0

# Set Isaac Lab path
export IsaacLab_PATH=/home/jessie/NokkTsang/IsaacLab-1.0.0

# Add Isaac Lab and orbit-surgical extensions to PYTHONPATH
export PYTHONPATH="${IsaacLab_PATH}/source/extensions/omni.isaac.lab:${IsaacLab_PATH}/source/extensions/omni.isaac.lab_tasks:${IsaacLab_PATH}/source/extensions/omni.isaac.lab_assets:$HOME/NokkTsang/orbit-surgical/source/extensions/orbit.surgical.tasks:$HOME/NokkTsang/orbit-surgical/source/extensions/orbit.surgical.assets:$HOME/NokkTsang/orbit-surgical/source/extensions/orbit.surgical.ext:${PYTHONPATH}"

# Run with Isaac Sim's Python
${IsaacLab_PATH}/_isaac_sim/python.sh "$@"
