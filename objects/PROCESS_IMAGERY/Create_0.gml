// Global Surface
global.textsurface = noone;

//////////////////////////////////
//                              //
//   BktGlitch 1.0              //
//    Written by Blokatt        //
//     (Jan Vorisek)            //
//      @blokatt | blokatt.net  //
//       jan@blokatt.net        //
//        14/08/2017            //
//                              //
//////////////////////////////////

randomize();

BktGlitch_init(); //getting uniform pointers
application_surface_draw_enable(false); //disabling automatic redrawing of the application surface
display_set_gui_size(640, 480); //making sure the GUI layer stays always the same size

intensity = 0; //every time the ball bounces, we'll change the effect intensity
seed = random(1); //we'll also change the RNG seed every time

zalgoizer_init();
original_caption = "Meimei";
interpolated_caption = original_caption;
window_set_caption(zalgoizer_zalgoize(original_caption));
alarm[0] = 2;