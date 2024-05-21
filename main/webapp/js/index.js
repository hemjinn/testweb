const signInBtn = document.getElementById("signIn");
const signUpBtn = document.getElementById("signUp");
const signUpForm = document.getElementById("form1");   // signUp 폼
const signInForm = document.getElementById("form2");  // signIn 폼
const container = document.querySelector(".container");

// "signIn" 버튼 클릭 시 UI 상태 변경
signInBtn.addEventListener("click", () => {
  // UI 상태 변경
  container.classList.remove("right-panel-active");
  // "signIn" 버튼 클릭 시 폼 제출 이벤트 리스너 추가
  signInForm.addEventListener("submit", handleSignInSubmit);
  // "signUp" 폼 제출 이벤트 리스너 제거
  signUpForm.removeEventListener("submit", handleSignUpSubmit);
});

signUpBtn.addEventListener("click", () => {
  container.classList.add("right-panel-active");
  signUpForm.addEventListener("submit", handleSignUpSubmit);
  signInForm.removeEventListener("submit", handleSignInSubmit);
});