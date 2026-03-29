Godot doesn't use the blue channel of normal maps, so the techniques in this
video don't really apply. If you don't select 'Normal Map' on the Texture2D
node, or hint the sampler2D as 'normal' in code, then Godot won't throw out
your blue channel and  you might be able to apply the techniques Ben goes over.
But, I had trouble when trying to do that -- the normals ended up looking kind
of broken. Basically, I don't think Godot is setup for these methods. I might
be wrong and if you manage to get them working, let me know:
alexparismars@gmail.com
I'd appreciate it.

Anyway, I've included a shader that combines the normal maps in a basic but,
from what I can tell, decent way.

Here's Godot's documentation on normal maps.
https://docs.godotengine.org/en/stable/tutorials/3d/standard_material_3d.html#normal-map
