package org.cdevs.drugpromotion

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("a4bbaf2f-d369-4c5f-8bef-9c17f2ed2352")
    }
}