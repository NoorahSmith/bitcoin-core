Rename all Bitcoin instances to Smith coin . 

Create a build folder 
```cmake ..```

Install tools required for building

```sudo apt install build-essential  ```

If getting error about sqlite , install dev tools 

 Could NOT find SQLite3 (missing: SQLite3_INCLUDE_DIR SQLite3_LIBRARY)
 
```sudo apt install libsqlite3-dev```

for further Cmake errors about Boost like below
CMake Error at cmake/module/AddBoostIfNeeded.cmake:32 (find_package):
  Could not find a package configuration file provided by "Boost" (requested
  version 1.73.0) with any of the following names:
  
install boost lib

```sudo apt install libboost-all-dev ```

Build the code after CMake 

```make -j$(nproc)```

This will compile all the tools in the build folder 

![image](https://github.com/user-attachments/assets/30c1be8c-4be5-43aa-9f57-f72d2e563fb7)


