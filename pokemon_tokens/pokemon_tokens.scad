/********
Pokemon Damage Tokens (2-part for MMU).

Requires the Symbola font to be installed for emoji rendering.

1. Uncomment your desired token type.
2. To render parts separately comment the call to either RenderBody() or RenderText().
********/

// poison
token_diameter = 22;
token_color = "green";
text_content = "💀";
text_size = 13;
text_font = "Symbola:style=Bold";

// burn
/*
token_diameter = 22;
token_color = "red";
text_content = "🔥";
text_size = 11;
text_font = "Symbola:style=Bold";
*/

// damage 10
/*
token_diameter = 15;
token_color = "yellow";
text_content = "10";
text_size = 8;
text_font = "Arial:style=Bold";
*/

// damage 50
/*
token_diameter = 15;
token_color = "orange";
text_content = "50";
text_size = 8;
text_font = "Arial:style=Bold";
*/

// damage 100
/*
token_diameter = 15;
token_color = "red";
text_content = "100";
text_size = 6;
text_font = "Arial:style=Bold";
*/

// global
text_height = 0.5;
text_emboss = 0.1;
text_color = "white";
token_height = 2;
token_resolution = 180;


module TokenBody(){
    color(token_color){
        cylinder(h=token_height, d=token_diameter, $fn=token_resolution);
    }
}

module TokenText(){
    translate([0,0,(token_height-text_height+text_emboss)]) {
        color(text_color){
            linear_extrude(height=text_height) {
                text(text=text_content, size=text_size, font=text_font, halign="center", valign="center");
            }
        }
    }
}

module RenderBody(){
    difference(){
        TokenBody();
        TokenText();
    }
}

module RenderText(){
    TokenText();
}

RenderBody();
//RenderText();