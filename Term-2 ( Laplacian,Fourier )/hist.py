import numpy as np
import matplotlib.pyplot as plt
from scipy.ndimage import convolve

def generate_twotone(rows, cols):
    """
    Generate a 'two-tone' image where the left half is white (255)
    and the right half is black (0).
    """
    img = np.zeros((rows, cols), dtype=np.uint8)
    img[:, :cols//2] = 255  # left half white
    return img

def generate_checker(rows, cols, square_size=32):
    """
    Generate a checkerboard pattern of white (255) and black (0)
    squares of size 'square_size'.
    """
    img = np.zeros((rows, cols), dtype=np.uint8)
    for r in range(rows):
        for c in range(cols):
            # Determine which square by dividing row & col by square_size
            if ((r // square_size) + (c // square_size)) % 2 == 0:
                img[r, c] = 255
            else:
                img[r, c] = 0
    return img

# 1) Create the two images
rows, cols = 256, 256
I_twotone  = generate_twotone(rows, cols)
I_checker  = generate_checker(rows, cols, square_size=32)

# 2) Create a 3x3 box filter and convolve
kernel_3x3 = np.ones((3, 3), dtype=np.float32) / 9.0
I_twotone_blur = convolve(I_twotone, kernel_3x3, mode='constant', cval=0)
I_checker_blur = convolve(I_checker, kernel_3x3, mode='constant', cval=0)

# 3) Display original & blurred images side by side
fig, axes = plt.subplots(2, 2, figsize=(8, 8))
axes[0,0].imshow(I_twotone, cmap='gray', vmin=0, vmax=255)
axes[0,0].set_title('Two-Tone Original')
axes[0,1].imshow(I_twotone_blur, cmap='gray', vmin=0, vmax=255)
axes[0,1].set_title('Two-Tone Blurred')
axes[1,0].imshow(I_checker, cmap='gray', vmin=0, vmax=255)
axes[1,0].set_title('Checkerboard Original')
axes[1,1].imshow(I_checker_blur, cmap='gray', vmin=0, vmax=255)
axes[1,1].set_title('Checkerboard Blurred')

for ax in axes.ravel():
    ax.axis('off')
plt.tight_layout()
plt.show()

# 4) Plot better-scaled histograms (0..255), normalized to 'probability'
fig2, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 4))
bins = np.arange(257)  # 256 bins covering 0..255

# A) Two-Tone blurred
hist_twotone, _ = np.histogram(I_twotone_blur, bins=bins)
hist_twotone = hist_twotone / float(I_twotone_blur.size)  # normalize
ax1.bar(bins[:-1], hist_twotone, width=1.0, color='red')
ax1.set_xlim([0,255])
ax1.set_title('Histogram: Two-Tone (Blurred)')
ax1.set_xlabel('Intensity')
ax1.set_ylabel('Probability')

# B) Checkerboard blurred
hist_checker, _ = np.histogram(I_checker_blur, bins=bins)
hist_checker = hist_checker / float(I_checker_blur.size)
ax2.bar(bins[:-1], hist_checker, width=1.0, color='blue')
ax2.set_xlim([0,255])
ax2.set_title('Histogram: Checkerboard (Blurred)')
ax2.set_xlabel('Intensity')
ax2.set_ylabel('Probability')

plt.tight_layout()
plt.show()
