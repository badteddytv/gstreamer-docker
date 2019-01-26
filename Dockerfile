FROM ubuntu:18.04

ARG GST_VERSION=1.14.4

RUN apt-get update -y && apt-get upgrade -y && \
apt install -y \
libglib2.0-0 \
libnice10 \
libnice-dev \
libjson-glib-1.0 \
libjson-glib-dev \
libsoup2.4-dev \
libssl-dev \
libreadline-dev \
libsrtp0-dev \
libvpx-dev \
libvpx5 \
python3-gst-1.0 \
libsoup2.4-dev \
autoconf \
automake \
libtool \
wget \
bison \
flex \
git \
gtk-doc-tools \
libopus-dev \
libpcre3-dev \
libx264-152 \
libgirepository1.0-dev \
librtmp-dev \
libfaad-dev \
libfaac-dev \
nasm

RUN git clone --recursive https://github.com/cisco/openh264.git \
    && cd openh264 \
    && make -j8 \
    && make install \
    && cd / \
# http://www.linuxfromscratch.org/blfs/view/svn/multimedia/gstreamer10.html
    && wget https://gstreamer.freedesktop.org/src/gstreamer/gstreamer-$GST_VERSION.tar.xz \
    && tar xvfJ gstreamer-$GST_VERSION.tar.xz > /dev/null \
    && cd gstreamer-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
    # gst-plugins-base
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-base/gst-plugins-base-$GST_VERSION.tar.xz \
    && tar xvfJ gst-plugins-base-$GST_VERSION.tar.xz > /dev/null \
    && cd gst-plugins-base-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
    # libnice
    && git clone https://github.com/libnice/libnice.git \
    && cd libnice \
    && ./autogen.sh --prefix=/usr --with-gstreamer --enable-static --enable-static-plugins --enable-shared --without-gstreamer-0.10 --disable-gtk-doc \
    && make install \
    && cd / \
    # gst-plugins-good
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-good/gst-plugins-good-$GST_VERSION.tar.xz \
    && tar xvfJ gst-plugins-good-$GST_VERSION.tar.xz > /dev/null \
    && cd gst-plugins-good-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
    # gst-plugins-bad
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-bad/gst-plugins-bad-$GST_VERSION.tar.xz \
    && tar xvfJ gst-plugins-bad-$GST_VERSION.tar.xz > /dev/null \
    && cd gst-plugins-bad-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
    # gst-plugins-ugly
    && wget https://gstreamer.freedesktop.org/src/gst-plugins-ugly/gst-plugins-ugly-$GST_VERSION.tar.xz \
    && tar xvfJ gst-plugins-ugly-$GST_VERSION.tar.xz > /dev/null \
    && cd gst-plugins-ugly-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
    # gst-libav
    && wget https://gstreamer.freedesktop.org/src/gst-libav/gst-libav-$GST_VERSION.tar.xz \
    && tar xvfJ gst-libav-$GST_VERSION.tar.xz > /dev/null \
    && cd gst-libav-$GST_VERSION \
    && ./configure --enable-introspection --prefix=/usr --enable-gtk-doc-html=no \
    && make -j8 \
    && make install \
    && cd / \
