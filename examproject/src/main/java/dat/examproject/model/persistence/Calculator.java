package dat.examproject.model.persistence;

import dat.examproject.model.entities.Order;

import java.util.ArrayList;

import static java.lang.Math.ceil;
import static java.lang.Math.floor;

public class Calculator {
    double widthPiece = 0.55;
    public double calPost(double length, boolean shed){
        // Starter med 4, hvis der er skur på, skal der være 4 ekstra, og så skal der sættes 2 ind per 3-3,3 meter
        int post = 5; // Starts of as 4, because there is a minimum of 5 posts
        double extraPosts = 0.0;
        if(shed == true){ // If there is a shed connected, add 4 extra posts
            post += 4;
            extraPosts = floor((length-(2.5*widthPiece))/3.3)*2;
        }
        else {
            extraPosts = floor((length-(4*widthPiece))/3.3)*2;
        }
        System.out.println(extraPosts);
        return post+extraPosts;
    }

    public double calRafters(double length){
        int rafters = 2; // There is at least 2 rafters, 1 in each end
        double extraRafters = floor(length/(widthPiece+0.045));
        System.out.println(extraRafters);
        return rafters+extraRafters;
    }

    public double calShedBoards(double length, double width){
        double lengthBoards = length*0.2;
        double widthBoards = width*0.2;
        double total = ceil(lengthBoards+widthBoards)*100;
        return total;
    }

    public double calLooseWoodGavl(double length){
        double gavl = ceil(length/2.7)*6;
        return gavl;
    }

    public double calLooseWoodSite(double width){
        double site = ceil(width/2.4)*4;
        return site;
    }
}
