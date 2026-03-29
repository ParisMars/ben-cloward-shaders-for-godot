shader_type canvas_item;

/* 
You can just duplicate nodes if you're using per-instance stuff. You don't have
to create a whole new shader. You can get pretty creative with this, too. You
can have functions in that one shader that do all sorts of things, and
depending on what per-instance information is passed, different functions can
be called. Although it would probably be cleaner to just have separate shaders
for for meaningfully distinct effects.
"There is a practical maximum limit of 16 instance uniforms per shader."

Creating a new sprite, without duplicating, achieves the same result.
*/

instance uniform vec4 per_instance_colour : source_color;

void fragment() {
    // Per instance stuff
    COLOR = per_instance_colour;
}
