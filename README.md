# Linux Java Debs

A generic APT repository for Java desktop applications packaged as `.deb` files.

Applications are:
- Built using `jpackage`
- Bundled with their own Java runtime
- Installable without system Java

This repository is hosted using **GitHub Pages** and targets **Debian-based Linux systems**.

---

## 🖥 Supported Systems

### Fully Supported
- **Linux Mint** (primary target)

### Manual Setup Supported
- Ubuntu
- Debian
- Pop!_OS
- Zorin OS
- Other Debian-based distributions (amd64)

---

## 🚀 Installation (Optional Script – Linux Mint)

> `setup.sh` is **optional**.  
> It automates standard APT steps and is intended mainly for **Linux Mint**.
> All actions can be done manually on any Debian-based system.

### 1️⃣ Download setup script
```bash
curl -O https://ahansantra.github.io/linux-java-debs/setup.sh
chmod +x setup.sh
```

### 2️⃣ Add repository
```bash
./setup.sh --add-repo
```

### 3️⃣ List available packages (repo-only)
```bash
./setup.sh --list
```

### 4️⃣ Install a package
```bash
./setup.sh --install calculator
```

### 5️⃣ Install all packages
```bash
./setup.sh --install-all
```

### 6️⃣ Remove a package
```bash
./setup.sh --remove calculator
```

### 7️⃣ Completely purge a package
```bash
./setup.sh --purge calculator
```

### 8️⃣ Remove the repository
```bash
./setup.sh --remove-repo
```

---

## 🔧 Manual Installation (All Debian-based Linux)

### 1️⃣ Add GPG key
```bash
curl -fsSL https://ahansantra.github.io/linux-java-debs/linux-java-debs.gpg \
| sudo gpg --dearmor -o /usr/share/keyrings/linux-java-debs.gpg
```

### 2️⃣ Add APT source
```bash
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/linux-java-debs.gpg] \
https://ahansantra.github.io/linux-java-debs stable main" \
| sudo tee /etc/apt/sources.list.d/linux-java-debs.list
```

### 3️⃣ Update package list
```bash
sudo apt update --allow-releaseinfo-change
```

### 4️⃣ Install applications
```bash
sudo apt install calculator
```

---

## 🗑 Manual Repository Removal

```bash
sudo rm /etc/apt/sources.list.d/linux-java-debs.list
sudo rm /usr/share/keyrings/linux-java-debs.gpg
sudo apt update
```

---

## 🔁 Updates

Once installed, applications update normally using:
```bash
sudo apt upgrade
```

---

## 📦 Repository Layout

```text
pool/<app-name>/<version>/<package>.deb
```

Example:
```text
pool/calculator/1.2.0/calculator_1.2.0_amd64.deb
```

---

## 🧑‍💻 Developer Workflow

1. Build Java project using Gradle
2. Create `.deb` using `jpackage`
3. Copy `.deb` into:
   ```
   pool/<app-name>/<version>/
   ```
4. Run:
   ```bash
   ./update-repo.sh
   ```
5. Commit and push to GitHub

GitHub Pages automatically serves the updated repository.

---

## 🔐 Security

- Repository metadata is GPG signed
- APT verifies packages automatically
- No system Java installation required

---

## 📜 Notes

- This repository distributes binaries only
- Each application may have its own license
- Intended for personal and small-scale community use
