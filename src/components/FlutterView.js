import React, { useEffect, useRef, memo } from "react";
import SyncLoader from "react-spinners/SyncLoader";


"use strict";

// The global _flutter namespace
// declare var _flutter: any;

// global promise is needed to avoid race conditions
// when component is mounted and immediately unmounted,
// e.g. in a React strict mode
let engineInitializerPromise = null;//: Promise<any> | null = null;

// interface FlutterViewProps {
//   assetBase?: string;
//   src?: string;
//   appLoaded?: (state: any) => void;
// }

export const FlutterView = memo(({ assetBase, src, appLoaded }) => {
  const ref = useRef(null);

  useEffect(() => {
    let isRendered = true;
    const initFlutterApp = async () => {
      console.log("create Flutter engine initializer promise...");
      engineInitializerPromise = new Promise((resolve, reject) => {
        console.log("setup Flutter engine initializer...");
        _flutter.loader.loadEntrypoint({
          entrypointUrl: src,
          onEntrypointLoaded: async (engineInitializer) => {
            resolve(engineInitializer);
          },
        });
      });
      const engineInitializer = await engineInitializerPromise;
      if (!isRendered) return;

      console.log("initialize Flutter engine on %s...", ref.current);
      const appRunner = await engineInitializer?.initializeEngine({
        hostElement: ref.current,
        renderer: "canvaskit",
        assetBase,
      });


      if (!isRendered) return;

      console.log("run Flutter engine...");
      console.log({ appRunner });

      await appRunner?.runApp();
    };
    initFlutterApp();

    const eventListener = (event) => {
      let state = (event).detail;

      console.log({ state })

      if (appLoaded) {
        appLoaded(state);
      }
    };

    ref.current?.addEventListener("flutter-initialized", eventListener, {
      once: true,
    });

    return () => {
      console.log("Flutter stopped rendering");
      isRendered = false;
      ref.current?.removeEventListener("flutter-initialized", eventListener);
    };
  }, []);
  return (
    <div
      ref={ref}
      style={{
        height: "100%",
        minHeight: "90vh",
        width: "100%",
        flex: "1 0 calc(100vh - var(--ifm-navbar-height, 3.75rem))",
        padding: "1rem"
      }}>
      <div style={{ height: "100%", width: "100%", display: "flex", justifyContent: "center", alignItems: "center" }}>
        <SyncLoader color="var(--ifm-color-primary)"></SyncLoader>
      </div>
    </div>
  );
});
