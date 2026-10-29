"""Adds the soft paper grain used by the Tales From the Sphinx art."""
import sys, glob, os
import numpy as np
from PIL import Image, ImageFilter

src, dst = sys.argv[1], sys.argv[2]
os.makedirs(dst, exist_ok=True)
rs = np.random.RandomState(42)
for f in sorted(glob.glob(os.path.join(src, '*.png'))):
    im = Image.open(f).convert('RGB')
    a = np.asarray(im).astype(np.float32)
    h, w, _ = a.shape
    fine = rs.normal(0, 1, (h, w))
    coarse = np.asarray(Image.fromarray(((rs.normal(0, 1, (h // 6, w // 6)) * 40) + 128).clip(0, 255).astype(np.uint8)).resize((w, h), Image.BICUBIC)).astype(np.float32) - 128
    n = fine * 3.5 + coarse * 0.07
    a = a + n[..., None] * (0.55 + a / 255 * 0.6)
    out = Image.fromarray(a.clip(0, 255).astype(np.uint8))
    out = out.filter(ImageFilter.UnsharpMask(radius=1, percent=30, threshold=2))
    out.save(os.path.join(dst, os.path.basename(f)), optimize=True)
    print('finished', os.path.basename(f))
