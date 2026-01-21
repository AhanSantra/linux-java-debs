# Linux Java Debs

A generic APT repository for Java desktop applications packaged as `.deb` files.

Applications are:
- Built using `jpackage`
- Bundled with their own Java runtime
- Installable without system Java

Hosted via **GitHub Pages**.

---

## 🖥 Supported Systems

### Fully Supported
- **Linux Mint**

### Manual Setup Supported
- Ubuntu
- Debian
- Pop!_OS
- Zorin OS
- Other Debian-based distributions (amd64)

---

## 🚀 Installation (Linux Mint – Optional Script)

> `setup.sh` is **optional** and designed for **Linux Mint**.  
> All steps can be done manually on any Debian-based system.

### 1️⃣ Download setup script
```bash
curl -O https://ahansantra.github.io/linux-java-debs/setup.sh
chmod +x setup.sh
```

### 2️⃣ Add repository
```bash
./setup.sh --add-repo
```

### 3️⃣ List available packages
```bash
./setup.sh --list
```

### 4️⃣ Install a package
```bash
./setup.sh --install calculator
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

## 🔁 Updates

```bash
sudo apt upgrade
```

---

## 📦 Repository Layout

```
pool/<app-name>/<version>/<package>.deb
```

---

## 🧑‍💻 Developer Workflow

1. Build Java project with Gradle
2. Package using `jpackage`
3. Copy `.deb` into:
   ```
   pool/<app-name>/<version>/
   ```
4. Run:
   ```bash
   ./update-repo.sh
   ```
5. Commit and push to GitHub

---

## 🔐 Security

- Repository metadata is GPG signed
- APT verifies packages automatically
- No system Java required
