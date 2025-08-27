# Use official ROS 2 Humble desktop image as base
FROM osrf/ros:humble-desktop-full

# Install useful packages inside container
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-opencv \
    nano \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /root/ros2_ws

# Copy your ROS2 workspace source code into container
COPY ./src ./src

# Build the ROS2 workspace
RUN /bin/bash -c "source /opt/ros/humble/setup.bash && colcon build"

# Source ROS 2 environment on startup
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc

# Default command when container starts
CMD ["bash"]
