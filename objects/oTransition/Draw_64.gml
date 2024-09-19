/// @desc

switch (type) {
    case TRANSITION_TYPE.SLIDE:
        draw_set_color(c_black);
		draw_rectangle(0, 0, width, percent * heightHalf, false);
		draw_rectangle(0, height, width, height - (percent * heightHalf), false);
        break;
		
	case TRANSITION_TYPE.FADE:
        // code here
        break;
		
	case TRANSITION_TYPE.PUSH:
        // code here
        break;
		
	case TRANSITION_TYPE.STAR:
        // code here
        break;
		
	case TRANSITION_TYPE.WIPE:
        // code here
        break;
		
    default:
        // code here
        break;
		
}




