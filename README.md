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

### Create the SDK

Clone the meta-zeroasic layer:
```bash
mkdir sdk && cd sdk
git clone git@github.com:zeroasiccorp/meta-zeroasic.git
```

Yocto cannot use passphrases when fetching dependencies, so be sure your ssh-agent is running and your github ssh-key has been added to it. This can be done using the following commands:
```bash
eval "$(ssh-agent -s)"
ssh-add .ssh/<your-key>
```

Build the target images:
```bash
kas build ./zeroasic-sdk/kas/zeroasic-sdk-image.yml
```

Images will be created in build/tmp/deploy/images/efabric1/

Running the image on QEMU
```bash
kas shell ./zeroasic-sdk/kas/zeroasic-sdk-image.yml -c "runqemu serialstdio slirp"
```

Press "CTRL-a x" to exit QEMU.

Build the Extensible SDK:
```bash
kas shell ./zeroasic-sdk/kas/zeroasic-sdk-image.yml -c "bitbake -c populate_sdk_ext zeroasic-sdk-image"
```

The sdk will be created in build/tmp/deploy/sdk/

If running the SDK on pre-historic hosts, you may need to install a buildtools package with
up-to-date versions of build-essential packages. To create the buildtools-extendeded package,
run the following:
```bash
kas shell ./zeroasic-sdk/kas/zeroasic-sdk-image.yml -c "bitbake buildtools-extended-tarball"
```

The buildtools-extended pacakage can be found in:
```build/tmp/deploy/sdk/x86_64-buildtools-extended-nativesdk-standalone-2023.01.00.sh```

# Other resources

[improving-yocto-build-time](https://www.thegoodpenguin.co.uk/blog/improving-yocto-build-time/)
[faq no network](https://wiki.yoctoproject.org/wiki/How_do_I)
