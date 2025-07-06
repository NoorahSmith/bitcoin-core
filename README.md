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

Create new wallet and transfer BTC 



![Rpc-1](https://github.com/user-attachments/assets/bd02f3a9-aca4-4058-b87a-4c16bac449e2)
transfer with with fee . 


![send 21 tokens to receiver address](https://github.com/user-attachments/assets/bfe82fdd-b03b-46fc-af05-34b66438658b)
List all transactions 
![List transactions](https://github.com/user-attachments/assets/aada24c0-1bb6-4c4c-b785-420190505ac2)

Build the QT GUI
 ![buidl qt files](https://github.com/user-attachments/assets/1ab867d5-8878-4416-9091-f9e0943d6390)

Sender wallet 
![Qt wallet ](https://github.com/user-attachments/assets/c1c77a82-0bef-4e05-86fb-619e179c6859)

receiver wallet 


![Receiver wallet ](https://github.com/user-attachments/assets/4b296c91-2669-4c8a-9161-fda63ede1aea)




