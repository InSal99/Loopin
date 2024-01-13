//
//  EditProjectView.swift
//  Loopin
//
//  Created by Celine Margaretha on 13/01/24.
//

import SwiftUI

struct EditProjectView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var inputWidths: [String] = []
    @State private var inputLengths: [String] = []
    
    @State var projectToEdit: ProjectViewModel

    var body: some View {
        VStack(spacing: 20) {
            ScrollView(.vertical){
                ShortTextField(placeholder: "nama", field: $projectToEdit.project.name)
                LongTextField(placeholder: "deskripsi proyek", field: $projectToEdit.project.description)
                
                let endIndex = projectToEdit.project.subParts.count
                
                ForEach(0 ..< endIndex) { index in
                    let sample = projectToEdit.project.sample
                    let widthBinding = Binding<String>(
                        get: { String(projectToEdit.project.subParts[index].gauge.width) },
                        set: {
                            projectToEdit.project.subParts[index].gauge.width = Double($0) ?? 0
                            projectToEdit.project.subParts[index].gauge.updateStitch(sample: sample)
                        }
                    )
                    
                    let lengthBinding = Binding<String>(
                        get: { String(projectToEdit.project.subParts[index].gauge.length) },
                        set: {
                            projectToEdit.project.subParts[index].gauge.length = Double($0) ?? 0
                            projectToEdit.project.subParts[index].gauge.updateRow(sample: sample)
                        }
                    )
                    
                    ProjectPartInputCard(subPart: projectToEdit.project.subParts[index], inputWidth: widthBinding, inputLength: lengthBinding)
                }
            }
            
            
            Button{
                projectToEdit.update(project: projectToEdit.project)
                presentationMode.wrappedValue.dismiss()
            } label: {
                PrimaryButton(buttonText: "Update")
            }
            .padding(.top, 25)
        }
        .padding(.top, 25)
        .foregroundColor(.black)
    }
}

struct EditProjectView_Previews: PreviewProvider {
    static var previews: some View {
        EditProjectView(projectToEdit: ProjectViewModel(project: Project(type: "type", name: "name", image: "test", description: "description", preparation: "preparation", yarnType: "yarnType", yarnWeight: "yarnWeight", hookSize: "hookSize", stitchType: "stitchType", sample: Gauges(length: 0, width: 0, stitch: 0, row: 0))))
    }
}
