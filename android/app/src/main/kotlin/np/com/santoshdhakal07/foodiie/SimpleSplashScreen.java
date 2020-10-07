package np.com.santoshdhakal07.foodiie;

import android.content.Context;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import io.flutter.embedding.android.SplashScreen;

public class SimpleSplashScreen implements SplashScreen {
    @Nullable
    @Override
    public View createSplashView(@NonNull Context context, @Nullable Bundle savedInstanceState) {
        return LayoutInflater.from(context).inflate(R.layout.layout_splash_screen, null);
    }

    @Override
    public void transitionToFlutter(@NonNull Runnable onTransitionComplete) {
        onTransitionComplete.run();
    }
}
