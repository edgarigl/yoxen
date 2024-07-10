# Yocto Xen image builder

This is a Yocto/OE layer to build Xen enabled Linux distros.

More information on the Yocto project can be found here:
[Yocto Project Documentation](http://docs.yoctoproject.org/)

## Dependencies

This layer depends on:
* https://git.yoctoproject.org/git/poky
* https://git.openembedded.org/meta-openembedded

Users can setup their Yocto environment manually or use the provided Kas
scripts to automatically clone and setup the necessary layers.

## Prerequisites for the build host

For Ubuntu hosts, the list of packages is listed in apt-requirements.
Python requirements are listed in py-requirements.

To install them do the following:
```bash
sudo apt-get install -y $(cat apt-requirements)
pip install -r py-requirements
```

For more details see the following:
* [Yocto](https://docs.yoctoproject.org/ref-manual/system-requirements.html)
* [kas](https://kas.readthedocs.io/en/latest/userguide.html#dependencies-installation)
* [package-feeds-blog](https://ltekieli.com/openembedded/)

## Usage

First, edit kas/yoxen-arm64.yml and kas/yoxen-x86_64.yml to point to your
custom Xen repos.

To build an image for ARM64:
```bash
$ kas build kas/yoxen-arm64.yml

```

To build an image for x86:
```bash
$ kas build kas/yoxen-x86_64.yml

```

Sometimes Xen and the Xen-tools fail to build due to some the subdirectory qemu-xen-dir being in some way not up to date. If this happens, try the following.

```bash
$ touch your-xen-src/qemu-xen-dir
$ kas shell kas/yoxen-arm64.yml -c "bitbake -c cleanall xen-tools"
$ kas build kas/yoxen-arm64.yml
```

### SDK

To generate an SDK for ARM:
```bash
$ kas shell kas/yoxen-arm64.yml -c "bitbake -c populate_sdk core-image-minimal"
```

For x86:
```bash
$ kas shell kas/yoxen-x86_64.yml -c "bitbake -c populate_sdk xen-image-minimal"
```



## Ubuntu 2024

If bitbake fails with permission denied, this is a workaround:
```bash
sudo apparmor_parser -R /etc/apparmor.d/unprivileged_userns
```
