class Ads {

    static double getMargin(double height){

        double margin;

        if(height <= 400){

          margin = 32;

        } else if(height >= 400 && height < 720){

      margin = 50;

    } else if(height >= 720){

      margin = 90;

    }

    return margin;

  }
}