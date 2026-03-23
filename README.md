# APB-I2C Bridge UVM Verification Project

## 📌 Overview

This project focuses on the design verification of an **APB to I2C Bridge** using the **Universal Verification Methodology (UVM)** in SystemVerilog. The goal is to validate the functionality, protocol compliance, and robustness of the bridge that connects the APB (Advanced Peripheral Bus) interface with the I2C (Inter-Integrated Circuit) protocol.

---

## 🎯 Objectives

* Verify correct data transfer between APB and I2C interfaces
* Ensure protocol compliance for both APB and I2C
* Develop reusable UVM components
* Achieve high functional and code coverage
* Detect corner-case and boundary-condition bugs

---

## 🏗️ Design Under Test (DUT)

The DUT is an APB-I2C bridge which:

* Accepts transactions from APB master
* Converts them into I2C protocol operations
* Supports read and write operations
* Handles start, stop, acknowledge signals in I2C

---

## 🧪 Verification Environment

The verification environment is built using **UVM architecture**, consisting of:

### Components

* **Test** – Defines verification scenarios
* **Environment (env)** – Top-level container
* **Agent(s)**

  * APB Agent (Driver, Monitor, Sequencer)
  * I2C Agent (Driver, Monitor, Sequencer)
* **Scoreboard** – Compares expected vs actual output
* **Reference Model** – Predicts expected behavior
* **Coverage Collector** – Tracks functional coverage

---

## 🔄 Verification Flow

1. APB transactions are generated using sequences
2. Driver sends transactions to DUT
3. DUT converts APB transactions to I2C signals
4. Monitor captures DUT activity
5. Scoreboard checks correctness
6. Coverage is collected for analysis

---

## 🧰 Tools & Technologies

* **Language:** SystemVerilog
* **Methodology:** UVM (Universal Verification Methodology)
* **Simulator:** synopsis VCS 
* **Protocols:** APB, I2C

---

## 📂 Project Structure

```
├── rtl/                # DUT RTL code
├── tb/
│   ├── env/           # Environment
│   ├── agents/        # APB & I2C agents
│   ├── sequences/     # Test sequences
│   ├── tests/         # Testcases
│   ├── scoreboard/    # Scoreboard logic
│   └── coverage/      # Coverage models
├── sim/               # Simulation scripts
├── docs/              # Documentation
└── README.md
```

---

## ✅ Test Scenarios

* Basic read/write operations
* Back-to-back transactions
* Randomized transactions
* Error injection (invalid address, missing ACK)
* Boundary conditions

---

## 📊 Coverage Goals

* Functional coverage for:

  * Address range
  * Read/Write operations
  * Start/Stop conditions
* Code coverage:

  * Line
  * Toggle
  * FSM states

---

## 🚀 How to Run

1. Clone the repository:

   ```bash
   git clone <repo_link>
   cd apb-i2c-uvm
   ```

2. Compile the design and testbench:

   ```bash
   make compile
   ```

3. Run simulation:

   ```bash
   make run
   ```

4. View waveform:

   ```bash
   make wave
   ```

---

## 📈 Results

* verified protocol write and read transfer
* acheived functional  coverage upto 86%
* Verified protocol correctness
  

---

## 🔍 Key Learnings

* Practical implementation of UVM components
* Protocol-level verification (APB & I2C)
* Debugging complex verification issues
* Writing reusable and scalable testbenches

---

## 📎 Future Improvements

* Add formal verification
* Integrate assertions (SVA)
* Extend to AXI-I2C bridge
* Automate regression using CI/CD

---

## 👨‍💻 Author

Selva Ganesh.G

---

## ⭐ Acknowledgment

This project was developed as part of my VLSI verification course at ampere VLSI academy.

---

## 📬 Contact

Feel free to connect for collaboration or opportunities in VLSI Design Verification.
