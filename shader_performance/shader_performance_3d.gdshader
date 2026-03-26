shader_type spatial;

/*
If you have some bit of code you want to test the performance of,
put it in a function and then call that function in a loop.
For comparisons, let each bit of code you want to compare have its
own function.
*/

float useless_function(float time, int iterations) {
    
    float num; 
    for (int i = 0; i < iterations; i++) { 
        num *= sin(cos(sin(cos(sin(cos(time * 2.0))))));
    }
    return num;
}

void fragment() {
    ALBEDO = vec3(useless_function(TIME, 1000000));
}
