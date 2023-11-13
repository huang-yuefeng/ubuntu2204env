# This is guide on how to gradually construct a docker image with tool chains inside an internet access denied developping environment.
----

## Initialize the first docker image

Pull an original ubuntu image from the hub. If you are using python, you can manage you python environment by Anaconda. After that, you will have a GBs docker image. Upload this image into you github in the internet access free environment, and download it in the internet access denied environment, where must have github download access at least.

### divide original docker image into small pieces and push. 

```tar zcf - IMAGE_NAME | split -b 30m - PIECE_NAME. ```
 
Because github has a limitation on the file size to push. After that, push the pieces. Suggest every push should not be too big, so I limit every piece into 30MB, and push PIECE.a* in batch (PIECE.b*, PIECE.c*, et. al. in sequence). There will be 30*26=780MB, which is tested to be accepted by github. 

ps: morening, lunch, and evening will be good time to git push big files. Do trust me and save your time!
Use `docker save -o` instead of `docker export` in order to update image layer by layer. 


### download pieces and decompress to the original image in the internet access denied environment.

```cat PIECE_NAME.* >> IMAGE_NAME.tar.gz```
```tar zxvf IMAGE_NAME.tar.gz ```

## Update docker images

Where there should be updates to you environment, just update in the internet available environment and transfer the layer containing the updates inside. If your generate the new image by `docer save -o`, you can use diff.py to get the different layer. Follow the above method to transfer this different layer.
```python diff.py -o IMAGE_NAME:OLD_TAG  -n IMAGE_NAME:NEW_TAG```



