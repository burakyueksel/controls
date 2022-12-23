"""
Path Planning Sample Code with Randamized Rapidly-Exploring Random Trees (RRT)

author: AtsushiSakai(@Atsushi_twi)

"""

import matplotlib.pyplot as plt
import random
import math
import copy

show_animation = True


class RRT():
    """
    Class for RRT Planning
    """

    def __init__(self, start, goal, obstacleList,
                 randArea, expandDis=1.0, goalSampleRate=5, maxIter=500):
        """
        Setting Parameter

        start:Start Position [x,y]
        goal:Goal Position [x,y]
        obstacleList:obstacle Positions [[x,y,size],...]
        randArea:Ramdom Samping Area [min,max]

        """
        self.start = Node(start[0], start[1])
        self.end = Node(goal[0], goal[1])
        self.minrand = randArea[0]
        self.maxrand = randArea[1]
        self.expandDis = expandDis
        self.goalSampleRate = goalSampleRate
        self.maxIter = maxIter
        self.obstacleList = obstacleList

    def Planning(self, animation=True):
        """
        Pathplanning

        animation: flag for animation on or off
        """

        # in first iteration the nodeList is the start point of the tree. So single point
        self.nodeList = [self.start]
        while True:
            # Random Sampling
            if random.randint(0, 100) > self.goalSampleRate:                        # if a random integer greater than the sample rate of the goal
                rnd = [random.uniform(self.minrand, self.maxrand), random.uniform(
                    self.minrand, self.maxrand)]                                    # pick a random point from randArea, i.e. minrand=randArea[0] and maxrand=randArea[1]
            else:
                rnd = [self.end.x, self.end.y]                                      # take the end point as the random point.
                print('hello')

            # Find nearest node
            nind = self.GetNearestListIndex(self.nodeList, rnd)                     # indice of the nearest node.
            # print(nind)

            # expand tree
            nearestNode = self.nodeList[nind]
            theta = math.atan2(rnd[1] - nearestNode.y, rnd[0] - nearestNode.x)      # heading from random point to the nearest node

            newNode = copy.deepcopy(nearestNode)                                    # new node is first the copy of the old one. This to be changed.
            newNode.x += self.expandDis * math.cos(theta)                           # in x expandDis = expanding distance
            newNode.y += self.expandDis * math.sin(theta)                           # in y expandDis = expanding distance
            newNode.parent = nind                                                   # remember the parent of the new node

            if not self.__CollisionCheck(newNode, self.obstacleList):               # if no collision, continue, i.e. go back to the beginning of while and checn for new node 
                continue                                                            # else: execute the following lines.

            self.nodeList.append(newNode)                                           # add the new node to the node lists
            print("nNodelist:", len(self.nodeList))                                 # length of the node list

            # check goal
            dx = newNode.x - self.end.x
            dy = newNode.y - self.end.y
            d = math.sqrt(dx * dx + dy * dy)
            if d <= self.expandDis/2:                                                 # goal reached, break the while loop and exit
                print("Goal!!")
                break

            if animation:
                self.DrawGraph(rnd)

        path = [[self.end.x, self.end.y]]
        lastIndex = len(self.nodeList) - 1
        while self.nodeList[lastIndex].parent is not None:
            node = self.nodeList[lastIndex]
            path.append([node.x, node.y])
            lastIndex = node.parent
        path.append([self.start.x, self.start.y])

        return path

    def DrawGraph(self, rnd=None):
        """
        Draw Graph
        """
        plt.clf()
        if rnd is not None:
            plt.plot(rnd[0], rnd[1], "^k")
        for node in self.nodeList:
            if node.parent is not None:
                plt.plot([node.x, self.nodeList[node.parent].x], [
                         node.y, self.nodeList[node.parent].y], "-g")

        for (ox, oy, size) in self.obstacleList:
            plt.plot(ox, oy, "ok", ms=30 * size)

        plt.plot(self.start.x, self.start.y, "xr")
        plt.plot(self.end.x, self.end.y, "xr")
        plt.axis([-2, 15, -2, 15])
        plt.grid(True)
        plt.pause(0.01)

    def GetNearestListIndex(self, nodeList, rnd):
        dlist = [(node.x - rnd[0]) ** 2 + (node.y - rnd[1])
                 ** 2 for node in nodeList]
        minind = dlist.index(min(dlist))
        return minind

    def __CollisionCheck(self, node, obstacleList):

        for (ox, oy, size) in obstacleList:
            dx = ox - node.x
            dy = oy - node.y
            d = math.sqrt(dx * dx + dy * dy)
            if d <= size:
                return False  # collision

        return True  # safe


class Node():
    """
    RRT Node
    """

    def __init__(self, x, y):
        self.x = x
        self.y = y
        self.parent = None


def main():
    print("start simple RRT path planning")

    # ====Search Path with RRT====
    '''
    obstacleList = [
        (5, 5, 1),
        (3, 6, 2),
        (3, 8, 2),
        (3, 10, 2),
        (7, 5, 2),
        (9, 5, 2)
    ]  # [x,y,size]
    '''
    obstacleList = [
        (3, 3, 1),
        (2, 4, 2),
        (3, 8, 2),
        (12, 8, 2),
        (7, 5, 2),
        (9, 5, 2)
    ]  # [x,y,size]
    # Set Initial parameters
    boundaries =[-2, 15]                                        # define boundaries of the positions
    rrt = RRT(start=[0, 0], goal=[5, 10],
              randArea=boundaries, obstacleList=obstacleList)
    path = rrt.Planning(animation=show_animation)
    print("nNodelist:", path)                                   # path: first element is the goal, last element is the start.
    with open("path.txt","w") as f:
        f.write(str(boundaries)+'\n')                           # write the way point boundaries
        for item in path:
            f.write(str(item)+'\n')                             # write way points

    # Draw final path
    if show_animation:
        rrt.DrawGraph()
        plt.plot([x for (x, y) in path], [y for (x, y) in path], '-r')
        plt.grid(True)
        plt.show()


if __name__ == '__main__':
    main()
