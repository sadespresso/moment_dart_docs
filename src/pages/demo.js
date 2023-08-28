import React from "react";
import Layout from "@theme/Layout";

import useBaseUrl from '@docusaurus/useBaseUrl';
import { FlutterView } from "../components/FlutterView";

export default function DemoPage() {
  const assetBase = useBaseUrl("/demo/");
  const src = useBaseUrl("/demo/main.dart.js");

  return (
    <Layout title="moment_dart demo" description="Flutter Web Demo">
      <FlutterView assetBase={assetBase} src={src} />
    </Layout>
  );
}
