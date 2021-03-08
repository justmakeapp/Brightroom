//
// Copyright (c) 2018 Muukii <muukii.app@gmail.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

import PixelEngine
import PixelEditor

final class HardwareImageViewController : UIViewController {

  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var imageConatinerView: UIView!

  let imageView: UIView & HardwareImageViewType = {
    #if canImport(MetalKit) && !targetEnvironment(simulator)
    return MetalImageView()
    #else
    return GLImageView()
    #endif
  }()

  let image: CIImage = {
    return CIImage(contentsOf: URL(string: "https://images.unsplash.com/photo-1597522781074-9a05ab90638e?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D")!)!.transformed(by: .init(scaleX: 0.2, y: 0.2)).insertingIntermediate()
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    imageConatinerView.addSubview(imageView)
    imageView.frame = imageConatinerView.bounds
    imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

  }

  @IBAction func didChangeSliderValue(_ sender: Any) {

    let value = slider.value

    let result = HardwareImageViewController.blur(image: image, radius: Double(value * 50))!

    imageView.display(image: result)
  }

  static func blur(image: CIImage, radius: Double) -> CIImage? {

    let outputImage = image
      .clamped(to: image.extent)
      .applyingFilter(
        "CIGaussianBlur",
        parameters: [
          "inputRadius" : radius
        ])
      .cropped(to: image.extent)

    return outputImage
  }
}

