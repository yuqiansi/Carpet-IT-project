<template>
  <el-card class="card">
    <div style="text-align: center; margin-bottom: 30px">
      <b>Edit personal information</b>
    </div>

    <el-form label-width="60px">
      <el-form-item label="avatar">
        <el-upload
          class="avatar-uploader"
          :action="baseApi + '/avatar'"
          :headers="token"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
        >
          <img
            v-if="form.avatarUrl"
            :src="baseApi + form.avatarUrl"
            class="avatar"
          />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </el-form-item>

      <el-form-item label="Nickname">
        <el-input v-model="form.nickname" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="Phone number">
        <el-input v-model="form.phone" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="Email">
        <el-input v-model="form.email" autocomplete="off"></el-input>
      </el-form-item>
      <el-form-item label="Address">
        <el-input v-model="form.address" autocomplete="off"></el-input>
      </el-form-item>
      <el-button
        type="primary"
        style="font-size: 20px;margin-left: 190px; margin-top: 20px"
        @click="save"><i class="iconfont icon-r-yes" style="font-size: 22px;"></i>Confirm</el-button
      >
    </el-form>
    <el-popover placement="right" width="200" trigger="click">
      <el-form>
        <el-form-item label="New Password">
          <el-input
            type="password"
            v-model="resetPsw.newPassword"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-form-item label="Confirm Password">
          <el-input
            type="password"
            v-model="resetPsw.confirmPassword"
            autocomplete="off"
          ></el-input>
        </el-form-item>
        <el-button style="font-size: 15px;font-size: 20px;" type="primary" @click="toResetPassword"
          ><i class="iconfont icon-r-yes" style="font-size: 22px;"></i>Confirm</el-button
        >
      </el-form>
      <el-button
        slot="reference"
        type="warning"
        style="margin-left: 190px; margin-top: 20px; font-size: 20px;"
        @click="resetPsw = { newPassword: '', confirmPassword: '' }"
        ><i class="iconfont icon-r-lock" style="font-size: 22px;"></i>Reset Password</el-button
      >
    </el-popover>
  </el-card>
</template>

<script>
import md5 from "js-md5";

export default {
  name: "Person",
  data() {
    return {
      form: {},
      baseApi: this.$store.state.baseApi,
      user: localStorage.getItem("user")
        ? JSON.parse(localStorage.getItem("user"))
        : {},
      resetPsw: {
        newPassword: "",
        confirmPassword: "",
      },
    };
  },
  methods: {
    toResetPassword() {
      // 重置密码
      if (this.resetPsw.newPassword.trim() == "") {
        this.$message.error("New password cannot be none.");
        return;
      }
      if (this.resetPsw.confirmPassword != this.resetPsw.newPassword) {
        this.$message.error("Passwords didn't match:(");
        return;
      }
      this.request
        .get(
          "/user/resetPassword?id=" +
            this.user.id +
            "&newPassword=" +
            md5(this.resetPsw.newPassword)
        )
        .then((res) => {
          if (res.code === "200") {
            this.$message.success("Edit successfully");
            this.resetPsw = {
              newPassword: "",
              confirmPassword: "",
            };
          } else {
            alert(res.msg);
          }
        });
    },
    //图片上传成功钩子
    handleAvatarSuccess(res) {
      this.imageUrl = res.data;
      this.form.avatarUrl = this.imageUrl;
    },
    //提交事件
    save() {
      //把表格传给后台，保存到数据库
      this.request.post("/user", this.form).then((res) => {
        if (res.code === "200") {
          this.$message.success("Save Successfully");
          //把表格的数据更新到user中
          for (let key in this.form) {
            this.user[key] = this.form[key];
          }
          //更新localstorage的user
          localStorage.setItem("user", JSON.stringify(this.user));
          this.$emit("refresh");
          this.$router.go(0);
        } else {
          this.$message.error(res.msg);
        }
      });
    },
  },
  created() {
    this.request.get("/userinfo/" + this.user.username).then((res) => {
      if (res.code === "200") {
        this.form = res.data;
      } else {
        alert(res.msg);
      }
    });
    // this.form = this.user;
  },
  computed: {
    token() {
      return { token: this.user.token };
    },
  },
};
</script>

<style scoped>
.card {
  width: 500px;
  margin: 80px auto;
  padding: 30px;
}
.avatar-uploader {
  padding-bottom: 10px;
}
.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 138px;
  height: 138px;
  line-height: 138px;
  text-align: center;
}
.avatar {
  width: 138px;
  height: 138px;
  display: block;
}
</style>