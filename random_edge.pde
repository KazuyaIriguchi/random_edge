boolean isPaused = false; // アニメーションの状態を追跡するフラグ
float noiseStrength = 50; // ノイズの強度を設定
float noiseDecrease = 0; // ノイズの減少量

void setup() {
  //size(1280, 720); // キャンバスのサイズを設定
  fullScreen();
  smooth(8); // 描画を滑らかにする
}

void draw() {
  background(0); // 背景を黒に設定
  float radius = 150; // 円の基本的な半径を定義

  if (isPaused) {
    // アニメーションが一時停止している場合、ノイズの強度を減らす
    //noiseStrength = max(noiseStrength - noiseDecrease, 0);
    noiseStrength = 0;
    // ノイズの強度が0になったら、変動を止める
    if (noiseStrength == 0) {
      noiseDecrease = 0; // ノイズの減少を止める
    }
  } else {
    // アニメーションが再開している場合、ノイズの強度を増やす
    //noiseStrength = min(noiseStrength + noiseDecrease, 50);
    noiseStrength = 50;
  }

  translate(width / 2, height / 2); // 中心に原点を移動
  stroke(255); // 線の色を白に設定
  //noFill(); // 円を塗りつぶさない
  beginShape(); // 形状の描画を開始

  // ラジアンで円周をループ
  for (float a = 0; a < TWO_PI; a += radians(1)) {
    float xoff = map(cos(a), -1, 1, 0, 5); // x方向のノイズのオフセット
    float yoff = map(sin(a), -1, 1, 0, 5); // y方向のノイズのオフセット

    // ノイズのある半径を計算
    float noisyRadius = radius + noise(xoff, yoff, frameCount * 0.01) * noiseStrength; // 半径に動的なノイズを追加
    float x = noisyRadius * cos(a); // x座標を計算
    float y = noisyRadius * sin(a); // y座標を計算

    vertex(x, y); // 計算した位置に頂点を配置
  }
  endShape(CLOSE); // 形状の描画を終了
}

void mousePressed() {
  // マウスが押されたらアニメーションの状態をトグルし、ノイズの減少量を設定する
  if (isPaused) {
    // 再開する場合はノイズを増やす
    noiseDecrease = 0.1;
  } else {
    // 一時停止する場合はノイズを減らす
    noiseDecrease = 0.5;
  }
  isPaused = !isPaused;
}
