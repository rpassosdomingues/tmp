#!/bin/bash

# Clone e compile o ImageMagick
git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.0.10
cd ImageMagick-7.0.10
./configure && make && sudo make install
cd ..

# Instalar dependências do ImageMagick via apt
sudo apt update
sudo apt build-dep imagemagick

# Instalar Flatpak e adicionar repositórios adicionais
sudo apt install -y flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instalar programas Flatpak
flatpak install -y flathub \
    com.visualstudio.code \
    org.darktable.Darktable \
    org.upscayl.Upscayl \
    org.audacityteam.Audacity \
    com.github.jeromerobert.pdfarranger \
    com.github.unrud.VideoDownloader \
    org.kde.kdenlive \
    com.obsproject.Studio \
    com.spotify.Client \
    org.geogebra.GeoGebra \
    org.raspberrypi.rpi-imager \
    net.fasterland.converseen \
    org.inkscape.Inkscape \
    org.flozz.yoga-image-optimizer \
    net.codeindustry.MasterPDFEditor \
    org.jabref.jabref \
    org.vim.Vim \
    org.gnome.gitlab.somas.Apostrophe \
    nl.openoffice.bluefish \
    com.gopeed.Gopeed \
    org.jamovi.jamovi \
    org.librecad.librecad \
    com.prusa3d.PrusaSlicer \
    com.google.Chrome \
    org.videolan.VLC \
    org.openscad.OpenSCAD \
    com.github.PopoutApps.popout3d \
    md.obsidian.Obsidian \
    org.gimp.GIMP \
    org.kde.krita \
    org.blender.Blender \
    org.inkscape.Inkscape \
    org.freecadweb.FreeCAD \
    com.ultimaker.cura \
    cc.arduino.arduinoide \
    org.fritzing.Fritzing \
    art.taunoerik.tauno-serial-plotter \
    com.simulide.simulide \
    com.github.reds.LogisimEvolution \
    org.librepcb.LibrePCB \
    org.kicad.KiCad \
    com.anydesk.Anydesk \
    org.kde.kturtle \
    io.github.veusz.Veusz \
    org.pymol.PyMOL \
    org.kde.umbrello \
    org.cubocore.CorePaint \
    com.bambulab.BambuStudio \
    io.github.fizzyizzy05.binary \
    com.calibre_ebook.calibre \
    org.onlyoffice.desktopeditors \
    me.kozec.syncthingtk

# Instalar pacotes Python via pip
sudo apt install -y python3-pip
pip3 install opencv-python pillow scikit-image mahotas PyOpenGL mayavi pyvtk pymesh matplotlib numpy pandas bpy ezdxf scikit-learn tensorflow keras seaborn selenium jpype1 pymysql sqlalchemy tqdm

# Atualizar os flatpaks
flatpak update -y

# Atualizar o sistema via apt
sudo apt update -y
sudo apt upgrade -y

# Limpar os pacotes desnecessários
sudo apt autoclean -y
sudo apt autoremove -y

echo "Instalação concluída!"
