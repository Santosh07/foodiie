package np.com.santoshdhakal07.foodiie

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen

class MainActivity: FlutterActivity() {

    override fun provideSplashScreen(): SplashScreen? {
        //return super.provideSplashScreen()
        return SimpleSplashScreen()
    }
}
