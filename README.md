# AutoHyprland

<div align="center">

![Hyprland](https://img.shields.io/badge/Hyprland-Wayland-blue?style=for-the-badge&logo=wayland)
![Arch Linux](https://img.shields.io/badge/Arch%20Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Shell](https://img.shields.io/badge/Shell-ZSH-green?style=for-the-badge&logo=gnu-bash)
![License](https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge)

</div>

## 📖 Descripción

Script automatizado para instalar el entorno de trabajo **hacker minimalista** de **varfmx21** con Hyprland (Wayland). Basado en recursos y estilo de **s4vitar**, diseñado con un toque **DedSec** para pentesting y desarrollo.

## 🚀 Instalación Rápida

### Paso 0: Configurar Repositorios (Opcional)

```bash
# Instalar AUR helper y repositorios BlackArch
chmod +x repositories.sh
./repositories.sh
```
> 💀 Esto instalará **paru (AUR)** y repositorios de **BlackArch**

### Paso 1: Ejecutar Script Principal

```bash
# Dar permisos y ejecutar
chmod +x setup.sh
./setup.sh
```

### Paso 2: Selección de Wallpaper Manager

**🌊 SWWW** (Wallpapers con movimiento - Más recursos)
```
Opción: 1
```

**🖼️ Hyprpaper** (Wallpapers estáticos - Menos recursos)  
```
Opción: 2
```

### Paso 3: Elegir Wallpaper

## 🎨 Wallpapers Disponibles

### SWWW (Animated)
<div align="center">

| Wallpaper 1 | Wallpaper 2 |
|-------------|-------------|
| ![GIF 1](wallpapers/wallpaper_1.gif) | ![GIF 2](wallpapers/wallpaper_2.gif) |
| `Opción: 1` | `Opción: 2` |

</div>

### Hyprpaper (Static)
<div align="center">

| Wallpaper 1 | Wallpaper 2 |
|-------------|-------------|
| ![Static 1](wallpapers/wallpaper_1.jpg) | ![Static 2](wallpapers/wallpaper_2.png) |
| `Opción: 1` | `Opción: 2` |

| Wallpaper 3 |
|-------------|
| ![Static 3](wallpapers/wallpaper_3.jpg) |
| `Opción: 3` |

</div>

## ⚙️ Configuración

### 🖥️ Escalado de Pantalla

Si necesitas ajustar la escala de pantalla, edita `hyprland.conf`:

```properties
# Cambiar el último valor según necesites
monitor=,preferred,auto,1.25  # 125% scale
monitor=,preferred,auto,1.5   # 150% scale
monitor=,preferred,auto,2     # 200% scale
```

## 📦 Contenido Incluido

### 🛠️ Aplicaciones Core

| Componente | Aplicación |
|-----------|------------|
| **Terminal** | Kitty |
| **Shell** | ZSH (root + usuario) |
| **Window Manager** | Hyprland (Wayland) |
| **Font** | Hack Nerd Fonts |
| **Display Manager** | ly |
| **File Manager** | Thunar |
| **Screenshot** | Hyprshot |

### 🎯 Aplicaciones Extras

- 🎵 **Spotify** - Reproductor de música
- 🌐 **Brave** - Navegador web privado
- **VLC** - Reproductor multimedia

### 🔧 Herramientas de Sistema

- 📊 **Waybar** - Barra de estado
- 🔔 **SwayNC** - Centro de notificaciones  
- 🎨 **Wofi** - Launcher de aplicaciones
- 🔒 **Hyprlock** - Bloqueo de pantalla
