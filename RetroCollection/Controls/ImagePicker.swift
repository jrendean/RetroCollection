//
//  ImagePicker.swift
//  RetroCollection
//
//  Created by JR Endean on 1/10/22.
//

import SwiftUI

extension UIImage: Initable {
    
}

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @Binding var editorConfig: EditorConfig<UIImage>
   
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
 
        return imagePicker
    }
 
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
 
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.editorConfig.data = image
                parent.editorConfig.dismiss(save: true)
            }
            else {
                parent.editorConfig.dismiss(save: false)
            }
        }
    }
}

#if DEBUG
struct ImagePicker_Previews: PreviewProvider {
    struct StatefulPreviewWrapper: View {
        @State var testData: EditorConfig<UIImage>
       
        var body: some View {
            ImagePicker(sourceType: .photoLibrary, editorConfig: $testData)
        }
    }
    
    static var previews: some View {
        StatefulPreviewWrapper(
            testData: EditorConfig<UIImage>(data: UIImage(), mode: .add))
    }
}
#endif
