#!/bin/bash
# achrinstall.sh: Instalador personalizado para Arch Linux 32 bits con XFCE 4.20, Librewolf y Wayland experimental

# Comprobar si se ejecuta como root
if [[ $EUID -ne 0 ]]; then
  echo "Ejecuta este script como root (o con sudo)."
  exit 1
fi

# Actualización del sistema
echo "Actualizando el sistema..."
pacman -Syu --noconfirm

# Instalación de paquetes base y esenciales
echo "Instalando paquetes base..."
pacman -S --noconfirm base base-devel linux linux-firmware nano sudo networkmanager

# Habilitar NetworkManager
echo "Habilitando NetworkManager..."
systemctl enable NetworkManager
systemctl start NetworkManager

# Crear usuario si no existe (ajusta el nombre y contraseña a tu preferencia)
USERNAME="usuario"
if id "$USERNAME" &>/dev/null; then
  echo "El usuario $USERNAME ya existe."
else
  echo "Creando usuario $USERNAME..."
  useradd -m -G wheel -s /bin/bash "$USERNAME"
  echo "$USERNAME:password" | chpasswd
  # Permitir sudo para el grupo wheel
  if ! grep -q "^%wheel ALL=(ALL) ALL" /etc/sudoers; then
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
  fi
fi

# Instalación de XFCE 4.20 y componentes adicionales
echo "Instalando XFCE 4.20 y componentes..."
pacman -S --noconfirm xfce4 xfce4-goodies

# Instalación experimental de Wayland
echo "Instalando paquetes relacionados con Wayland (experimental)..."
pacman -S --noconfirm wayland weston

# Instalación de Librewolf (nota: verificar disponibilidad en Arch Linux 32 o usar AUR)
echo "Instalando Librewolf..."
if pacman -Ss librewolf | grep -q "^community/librewolf"; then
  pacman -S --noconfirm librewolf
else
  echo "Librewolf no se encuentra en los repos oficiales para 32 bits. Se recomienda compilarlo o buscar en AUR."
  # Aquí se podría incluir instrucciones adicionales para la compilación desde AUR o la descarga de un binario.
fi

# Configuración del entorno gráfico para el usuario
USER_XINIT="/home/$USERNAME/.xinitrc"
echo "Configurando el entorno gráfico..."
echo "# Iniciar XFCE" > "$USER_XINIT"
echo "exec startxfce4" >> "$USER_XINIT"
chown "$USERNAME":"$USERNAME" "$USER_XINIT"

# Mensaje final
echo "Instalación completada. Reinicia el sistema para aplicar todos los cambios."
