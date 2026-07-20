

# CAN communication implementation using the Zybo Z7-20 board, an USB-to-CAN adapter (SH-C31A), and a CAN bus transceiver (SN65HVD230).

## 🐧 Linux & SoC Integration (Zybo / Zynq)

Configured embedded Linux networking and SocketCAN protocol stacks (can-utils, interface bridging) on ARM/FPGA heterogeneous SoC platforms to monitor, parse, and verify live bus traffic.

## 🚀 Implementation Steps
### 1. Vivado Hardware Design

    Zynq Processing System Configuration: Enable the CAN controller and route it through EMIO (Extended Multiplexed I/O) to connect with the Programmable Logic (PL) pins.

    External Ports: Make the CAN interface signals external to generate the top-level ports (CAN_TX and CAN_RX).

    Constraints (.xdc): Assign the CAN TX/RX signals to the PMOD JE pins standard on the Zybo Z7-20 board.

    Build: Generate the block design wrapper, synthesize/implement, and export the hardware handoff file (.xsa).

### 2. PetaLinux & System Bring-Up

    Image Generation: Import the .xsa into PetaLinux, configure the kernel and rootfs to support SocketCAN and can-utils, and build the system image.

    Booting: Flash the Linux image onto an SD card and boot the Zybo Z7-20 board.

    Hardware Loopback & Testing:

        Connect the Zybo board (via the SN65HVD230 transceiver) and the USB-to-CAN adapter (SH-C31A) to form a physical 2-node CAN bus network.

        Bring up the CAN interface in Linux (ip link set can0 up ...).


## 💻 Usage & Testing Commands

Here are the step-by-step commands to bring up and test your CAN communication interface for both **Serial Mode (slcand)** and **SocketCAN Mode (gs_usb)**.

---

### 1. Serial Mode for USB-to-CAN (SH-C31A)

```bash
# 1. Connect the USB-to-CAN adapter (SH-C31A) to the PC. 
#    (Ensure its internal switch/mode is set to work mode OFF if required)

# 2. Check the kernel logs to find the assigned device name (e.g., ttyACM0 or ttyACM1)
sudo dmesg | tail -n 20

# 3. Attach the serial CAN device using slcand (set speed index -s6 for 500k baudrate)
sudo slcand -o -s6 -S 500000 /dev/ttyACM1 can0

# 4. Check if the can0 interface has been successfully created
ip link show can0

# 5. Bring up the interface
sudo ip link set can0 up

# 6. Verify that the initialization and settings are correct
ip -details link show can0

# 7. Start listening for incoming CAN frames (Run this in Terminal A)
candump can0

# 8. Send a test CAN frame (Run this in Terminal B)
cansend can0 123#DEADBEEF


```


----> the instruments for terminal: 
        Use cansend and candump to transmit and receive live CAN frames between the Zybo board and your host PC.
   <img width="786" height="533" alt="Screenshot from 2026-07-17 16-14-47" src="https://github.com/user-attachments/assets/25042318-d67a-47b4-8eda-087dfa7c232b" />

   

<img width="786" height="533" alt="Screenshot from 2026-07-17 16-14-55" src="https://github.com/user-attachments/assets/3e67044d-247c-428e-a226-98bf7064b445" />
