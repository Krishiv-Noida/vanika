from PIL import Image

src_path = r"C:\Users\nikhil.singh01_livsp\.gemini\antigravity-ide\brain\df8e9ebf-ec0f-43c5-9366-d856b8d3c86e\hanging_pothos_white_bg_1787695988330.jpg"
img = Image.open(src_path).convert("RGBA")
datas = img.getdata()

new_data = []
for item in datas:
    r, g, b, _ = item
    min_val = min(r, g, b)
    if min_val >= 246:
        # 100% transparent
        new_data.append((r, g, b, 0))
    elif min_val >= 232:
        # Smooth alpha falloff for smooth anti-aliased edges
        alpha = int((246 - min_val) / (246 - 232) * 255)
        new_data.append((r, g, b, alpha))
    else:
        # 100% opaque
        new_data.append((r, g, b, 255))

img.putdata(new_data)
out_path = "public/images/plants/hero_hanging_plant.png"
img.save(out_path, "PNG", optimize=True)
print(f"Successfully generated transparent PNG: {out_path} ({img.size})")
