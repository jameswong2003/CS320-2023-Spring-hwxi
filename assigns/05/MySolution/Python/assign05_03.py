####################################################
#!/usr/bin/env python3
####################################################
import sys
sys.path.append('./../../../05')
sys.path.append('./../../../../mypylib')
from mypylib_cls import *
####################################################
"""
HX-2023-03-14: 30 points
BU CAS CS320-2023-Spring: Image Processing
"""
####################################################
import math
####################################################
import kervec
import imgvec
####################################################
from PIL import Image
####################################################

def load_color_image(filename):
    """
    Loads a color image from the given file and returns a dictionary
    representing that image.

    Invoked as, for example:
       i = load_color_image("test_images/cat.png")
    """
    with open(filename, "rb") as img_handle:
        img = Image.open(img_handle)
        img = img.convert("RGB")  # in case we were given a greyscale image
        img_data = img.getdata()
        pixels = list(img_data)
        width, height = img.size
        return imgvec.image(height, width, pixels)
    # return None

def save_color_image(image, filename, mode="PNG"):
    """
    Saves the given color image to disk or to a file-like object.  If filename
    is given as a string, the file type will be inferred from the given name.
    If filename is given as a file-like object, the file type will be
    determined by the "mode" parameter.
    """
    out = Image.new(mode="RGB", size=(image.width, image.height))
    out.putdata(image.pixlst)
    if isinstance(filename, str):
        out.save(filename)
    else:
        out.save(filename, mode)
    out.close()
    # return None

####################################################
#
# HX-2023-03-18:
# This one is incorrect:
# def grey_of_color(clr):
#     (r0, b1, g2) = clr
#     return round(0.299*r0+0.587*b1+0.114*g2)
def grey_of_color(clr):
    (rr, gg, bb) = clr
    return round(0.299*rr+0.587*gg+0.114*bb)
#
####################################################

def image_invert_grey(ximg):
    return imgvec.image_make_map(ximg, lambda pix: 255 - pix)
def image_invert_color(ximg):
    return imgvec.image_make_map(ximg, lambda clr: 255 - grey_of_color(clr))

####################################################
#
balloons = \
    load_color_image("INPUT/balloons.png")
#
####################################################
#
save_color_image(image_invert_color(balloons), "OUTPUT/balloons_invert.png")
#
####################################################

def image_edges_grey(image):
    """
    This is an implementation of the Sobel operator.
    """
    krow = \
        kervec.kernel_make_pylist\
        (3, [-1, -2, -1, 0, 0, 0, 1, 2, 1])
    kcol = \
        kervec.kernel_make_pylist\
        (3, [-1, 0, 1, -2, 0, 2, -1, 0, 1])
    imgrow = \
        imgvec.image_kernel_correlate(image, krow, 'extend')
    imgcol = \
        imgvec.image_kernel_correlate(image, kcol, 'extend')
    imgres = \
        imgvec.image_make_z2map\
        (imgrow, imgcol, lambda x, y: math.sqrt(x*x + y*y))
    return imgvec.image_round_and_clip(imgres)

def image_edges_color(image):
    return image_edges_grey\
        (imgvec.image_make_map(image, lambda clr: 255 - grey_of_color(clr)))

####################################################

def image_blur_bbehav_grey(image, ksize, bbehav):
    ksize2 = ksize*ksize
    kernel = \
        kervec.kernel_make_pylist\
        (ksize, ksize2*[1.0/ksize2])
    return imgvec.image_round_and_clip\
        (imgvec.image_kernel_correlate(image, kernel, bbehav))

####################################################

def color_filter_from_greyscale_filter(filt):
    """
    Given a filter that takes a greyscale image as input and produces a
    greyscale image as output, returns a function that takes a color image as
    input and produces the filtered color image.
    """
    def image_filter(cimage):
        ww = cimage.width
        hh = cimage.height
        image0 = filt(imgvec.image_make_map(cimage, lambda clr: clr[0]))
        image1 = filt(imgvec.image_make_map(cimage, lambda clr: clr[1]))
        image2 = filt(imgvec.image_make_map(cimage, lambda clr: clr[2]))
        return imgvec.image_make_tuple\
            (hh, ww, \
             tuple(zip(image0.pixlst, image1.pixlst, image2.pixlst)))
    return lambda cimage: image_filter(cimage)

####################################################

def image_blur_bbehav_color(image, ksize, bbehav):
    return \
        color_filter_from_greyscale_filter\
        (lambda image: image_blur_bbehav_grey(image, ksize, bbehav))(image)

####################################################
# save_color_image\
#    (image_blur_bbehav_color(balloons, 5, 'extend'), "OUTPUT/balloons_blurred.png")
####################################################

def create_list(long_list, width):
    
    energy_list = []
    for i in range(0, len(long_list), width):
        row = long_list[i:i + width]
        energy_list.append(row)
        
    return energy_list
 
def find_min_seam(energy):
    n_rows, n_cols = len(energy), len(energy[0])
    dp = [[0] * n_cols for _ in range(n_rows)]
    paths = [[-1] * n_cols for _ in range(n_rows)]
    
    for j in range(n_cols):
        dp[0][j] = energy[0][j]
    
    for i in range(1, n_rows):
        for j in range(n_cols):
            
            if j == 0:
                dp[i][j] = energy[i][j] + min(dp[i-1][j], dp[i-1][j+1])
                if dp[i-1][j] < dp[i-1][j+1]:
                    paths[i][j] = j
                else:
                    paths[i][j] = j + 1
            elif j == n_cols - 1:
                dp[i][j] = energy[i][j] + min(dp[i-1][j], dp[i-1][j-1])
                if dp[i-1][j] < dp[i-1][j-1]:
                    paths[i][j] = j
                else:
                    paths[i][j] = j - 1
            else:
                dp[i][j] = energy[i][j] + min(dp[i-1][j-1], dp[i-1][j], dp[i-1][j+1])
                if dp[i-1][j-1] <= dp[i-1][j] and dp[i-1][j-1] <= dp[i-1][j+1]:
                    paths[i][j] = j - 1
                elif dp[i-1][j] <= dp[i-1][j-1] and dp[i-1][j] <= dp[i-1][j+1]:
                    paths[i][j] = j
                else:
                    paths[i][j] = j + 1
    
    # Find the minimum energy seam
    j = dp[n_rows-1].index(min(dp[n_rows-1]))
    seam = [(n_rows-1, j)]
    for i in range(n_rows-2, -1, -1):
        j = paths[i+1][j]
        seam.append((i, j))
    
    return seam[::-1]


def remove_seam(image, seam):
    hh, ww = image.height, image.width
    
    # Define a function that returns whether a pixel is part of the seam to be removed
    def is_seam_pixel(i, j):
        return (i, j) in seam
    
    row_pixels = imgvec.image_i2filter_pylist(image, lambda i, j, _: not is_seam_pixel(i, j))
    return imgvec.image_make_pylist(hh, ww - 1, row_pixels)

def image_seam_carving_color(image, ncol):
    """
    Starting from the given image, use the seam carving technique to remove
    ncols (an integer) columns from the image. Returns a new image.
    """
    assert ncol < image.width
    for i in range(ncol):
        energy = image_edges_color(image)
        energy_map = create_list(list(energy.pixlst), energy.width)
        seam = find_min_seam(energy_map)
        image = remove_seam(image, seam)
    return image

####################################################
save_color_image(image_seam_carving_color(balloons, 100), "OUTPUT/balloons_seam_carving_100.png")
####################################################

