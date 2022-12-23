# controls

## Quadrotor_Control_All

This has a lot of things: dynamic models of a quadrotor, near-hovering control laws, SE(3) control laws, trajectory generation using X-order filters or kinodynamic trajectory generation, trajectory smoothing and tracking, in general the implementations of the most known algorithms in the robotics literature for an automated flight of a drone.

The material was generated for the Introduction to Aerial Robotics lecture at University of Stuttgart in 2018/2019. See the course page [here](https://www.ist.uni-stuttgart.de/teaching/lectures/2018ws/iar/).

## PathPlanning

Path planning using RRT for obstacle avoidance. Use config.ini for definition of the obstacles. Give start point and end point. Watch RRT find the obstacle-free way points from start to the goal.

Using smoothe filters or other smooth trajectory generators (spline based or other dynamic ways), libraries in the Quadrotor_Control_All folder can take these obstacle-free way points and turn them into smooth trajectories for drone to follow.

The material was generated for the Introduction to Aerial Robotics lecture at University of Stuttgart in 2018/2019. See the course page [here](https://www.ist.uni-stuttgart.de/teaching/lectures/2018ws/iar/).

## StateEstimation

State estimation algorithms for a drone. AHRS: Attithde Heading Reference System.

The material was generated for the Introduction to Aerial Robotics lecture at University of Stuttgart in 2018/2019. See the course page [here](https://www.ist.uni-stuttgart.de/teaching/lectures/2018ws/iar/).