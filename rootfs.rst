======
RootFS
======


How to modify content of the existing rootfs?
=============================================

.. code-block:: bash

    # Create a temporary directory for extracting the contents of the cpio.gz archive image.
    mkdir temp

    # Extract the contents of the cpio.gz archive in the temporary folder.
    gunzip -c rootfs.cpio.gz | sh -c 'cd temp && cpio -i'

    # The temporary folder lists the filesystem as follows:
    bin boot dev etc home init lib media mnt proc run sbin sys tmp usr var

    # Make changes to the filesystem in the temporary folder.
    cp <path>/HelloWorld .

    # Repack the filesystem into a new cpio.gz archive.
    sh -c 'cd temp && find . | cpio -H newc -o' | gzip -9 > <path>/rootfs.cpio.gz

Create the cpio
===============

.. code-block:: bash

    $ (cd rootfs; find . | cpio -o -H newc | gzip -9 > ../rootfs.cpio.gz)
    
    find | cpio --quiet -o -H newc | bzip2 -c > /tmp/rootfs.cpio
