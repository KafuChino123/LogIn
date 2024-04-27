//
//  LogInView.swift
//  LogIn
//
//  Created by Raspberry on 2024/4/26.
//

import SwiftUI

struct LogInView: View {
    
    let darkBlue: Color = Color(red: 0.2, green: 0.2, blue: 0.4)
    
    @State private var email: String = loadUserData().email
    @State private var password: String = loadUserData().password
    
    @State private var rememberMe = false
    @State private var showPassword = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            
            Spacer()
            Spacer()
            
            Text("登录")
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(darkBlue)
            
            Text("请登录以获得XX服务。")
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
            
            Spacer()
            Spacer()
            
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 10))
                
                TextField("邮箱", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                    .padding()
            }
            .padding(.vertical)
            
            ZStack {
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .foregroundStyle(.opacity(0.25))
                    .clipShape(.rect(cornerRadius: 10))
                
                HStack {
                    if showPassword {
                        TextField("密码", text: $password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .frame(height: 40) // 设置相同的高度
                    } else {
                        SecureField("密码", text: $password)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .frame(height: 40) // 设置相同的高度
                    }
                    
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye" : "eye.slash")
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                .padding()
            }
            
            HStack(spacing: 2) {
                Button {
                    rememberMe.toggle()
                    if rememberMe {
                        saveUserData(email, password)
                    } else {
                        deleteUserData()
                    }
                } label: {
                    Image(systemName: rememberMe ? "checkmark.square" : "square")
                }
                
                Text("记住我")
                
                Spacer()
                
                Button {} label: {
                    Text("忘记密码")
                }
            }
            .padding()
            .foregroundStyle(.indigo)
            
            Button {
                if email != "" && password != "" {
                    //TODO: POST请求
                    postUserData(email, password)
                } else {
                    showingAlert = true
                }
            } label: {
                ZStack {
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 60)
                        .foregroundStyle(.indigo)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                    
                    Text("登录")
                }
            }
            .foregroundStyle(.white)
            .alert("密码或用户名无效，请重试(@_@)", isPresented: $showingAlert, actions: {})
            
            Spacer()
            Spacer()
            
            HStack {
                Rectangle()
                    .foregroundStyle(.opacity(0.35))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: 2)
                
                Text("第三方账号登录")
                    .font(.footnote)
                    .foregroundStyle(darkBlue)
                
                Rectangle()
                    .foregroundStyle(.opacity(0.35))
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, maxHeight: 2)
            }
            .padding(.vertical)
            
            
            Spacer()
            Spacer()
            
            HStack {
                Spacer()
                Spacer()
                Spacer()
                
                Button {} label: {
                    Image(.qq)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50)
                }
                
                Spacer()
                
                Button {} label: {
                    Image(.weixin)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 50)
                }
                
                Spacer()
                Spacer()
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Text("还没有账号？")
                    .foregroundStyle(.gray)
                
                Button {} label: {
                    Text("注册")
                }
                .foregroundStyle(.indigo)
            }
            .padding()
        }
        .padding()
        .ignoresSafeArea(.keyboard)
    }
}

#Preview {
    LogInView()
}
