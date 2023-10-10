<template>
  <div>
    <div class="demo-input-size">
      <el-select
        v-model="searchMode"
        placeholder="Please choose: "
        style="width: 150px; margin-right: 10px"
      >
        <el-option value="id" label="User ID"></el-option>
        <el-option value="username" label="Username"></el-option>
        <el-option value="nickname" label="Nickname"></el-option>
      </el-select>
      <el-input
        v-if="searchMode === 'id'"
        placeholder="Please enter the user ID: "
        prefix-icon="el-icon-search"
        style="width: 250px; padding-right: 5px"
        v-model="searchParams.id"
      ></el-input>
      <el-input
        v-if="searchMode === 'username'"
        placeholder="Please enter the username: "
        prefix-icon="el-icon-search"
        style="width: 250px; padding-right: 5px"
        v-model="searchParams.username"
      ></el-input>
      <el-input
        v-if="searchMode === 'nickname'"
        placeholder="Please enter the Nickname: "
        prefix-icon="el-icon-search"
        style="width: 250px; padding-right: 5px"
        v-model="searchParams.nickname"
      ></el-input>
      <el-button type="primary" @click="search">
        <i class="el-icon-a-042" style="padding-right: 6px"></i>
        Search
      </el-button>
      <el-button type="danger" @click="reload">
        <i class="el-icon-a-031" style="padding-right: 6px"></i>Reset
      </el-button>
    </div>
    <!--          按钮栏-->
    <div style="padding-top: 10px">
      <el-button type="primary" @click="handleAdd" style="font-size: 18px;"
        ><i class="el-icon-a-07" style="padding-right: 6px;font-size: 22px;"></i
        >Add</el-button
      >
      <el-button type="danger" @click="delBatch" style="font-size: 18px;"
        ><i class="el-icon-a-022" style="padding-right: 6px; font-size: 22px;"></i
        >Bulk Deletion</el-button
      >
    </div>
    <!--          弹窗-->
    <el-dialog :title="dialogTitle" :visible.sync="dialogFormVisible">
      <el-form label-width="50px" style="padding: 0 60px">
        <el-form-item label="Username" v-if="dialogTitle == 'Add new user'">
          <el-input v-model="user.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Password" v-if="dialogTitle == 'Add new user'">
          123456
        </el-form-item>
        <el-form-item label="Nickname">
          <el-input v-model="user.nickname" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Role">
          <el-select v-model="user.role" placeholder="Please select: ">
            <el-option
              v-for="item in roleOptions"
              :key="item.value"
              :label="item.label"
              :value="item.value"
            >
            </el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="Phone">
          <el-input v-model="user.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Email">
          <el-input v-model="user.email" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="Address">
          <el-input v-model="user.address" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false" style="font-size: 20px;"><i class="iconfont icon-r-left" style="font-size: 22px;"></i>Cancel</el-button>
        <el-button type="primary" @click="save" style="font-size: 20px;"><i class="iconfont icon-r-yes" style="font-size: 22px;"></i>Confirm</el-button>
      </div>
    </el-dialog>

    <!--          表格-->
    <el-table
      :data="tableData"
      background-color="black"
      @selection-change="handleSelectionChange"
    >
      <el-table-column type="selection"></el-table-column>
      <el-table-column prop="id" label="id" width="100"></el-table-column>
      <el-table-column
        prop="username"
        label="Username"
        width="150"
      ></el-table-column>
      <el-table-column label="Role" width="150">
        <template slot-scope="scope">
          <span v-if="scope.row.role === 'user'">Customer</span>
          <span v-if="scope.row.role === 'admin'">Administrator</span>
        </template>
      </el-table-column>
      <el-table-column
        prop="nickname"
        label="Nickname"
        width="180"
      ></el-table-column>
      <el-table-column prop="phone" label="Phone" width="180"></el-table-column>
      <el-table-column prop="email" label="Email" width="180"></el-table-column>
      <el-table-column
        prop="address"
        label="Address"
        width="350"
      ></el-table-column>
      <el-table-column label="Operation" width="250" fixed="right">
        <template slot-scope="scope">
          <el-button style="font-size: 18px;" type="success" @click="handleEdit(scope.row)"
            >
            <i class="el-icon-a-032" style="font-size: 22px;"></i>
            Edit
            </el-button
          >
          <el-button
            style="font-size: 18px;"
            type="danger"
            @click="handleDelete(scope.row.id)"
            >
            <i class="el-icon-a-022" style="font-size: 22px;"></i>
            Delete
            </el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <div class="block" style="flex: 0 0 auto">
      <el-pagination
        :current-page="currentPage"
        :page-sizes="[3, 5, 8, 10]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
        @size-change="handleSizeChange"
        @current-change="handleCurrentPage"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import md5 from "js-md5";

export default {
  name: "User",
  created() {
    this.load();
  },
  data() {
    return {
      tableData: [],
      roleOptions: [
        {
          value: "admin",
          label: "Administrator",
        },
        {
          value: "user",
          label: "Customer",
        },
      ],
      roleValue: "",
      total: 0,
      pageSize: 5,
      currentPage: 1,
      searchMode: "id",
      searchParams: {
        id: "",
        username: "",
        nickname: "",
      },
      dialogFormVisible: false,
      dialogTitle: "",
      user: {
        username: "",
        nickname: "",
        newPassword: "",
        role: "",
        phone: "",
        email: "",
        address: "",
      },
      multipleSelection: [],
    };
  },
  methods: {
    handleSizeChange(pageSize) {
      this.pageSize = pageSize;
      this.load();
    },
    handleCurrentPage(currentPage) {
      this.currentPage = currentPage;
      this.load();
    },
    handleSelectionChange(val) {
      this.multipleSelection = val;
    },

    load() {
      this.request
        .get("/user/page", {
          params: {
            pageNum: this.currentPage,
            pageSize: this.pageSize,
            id: this.searchParams.id,
            username: this.searchParams.username,
            nickname: this.searchParams.nickname,
          },
        })
        .then((res) => {
          if (res.code === "200") {
            this.tableData = res.data.records;
            this.total = res.data.total;
          }
        });
    },
    search() {
      this.currentPage = 1;
      this.load();
    },
    reload() {
      this.searchParams.id = "";
      this.searchParams.username = "";
      this.searchParams.nickname = "";
      this.load();
    },
    //插入或修改
    save() {
      if (this.dialogTitle == "Add new user") {
        if (this.user.username.trim() == "") {
          this.$message.error("The username should not be null.");
          return;
        }
        this.user.newPassword = md5("123456");
      }
      if (this.user.nickname.trim() == "") {
        this.$message.error("The nickname should not be null.");
        return;
      }
      if (this.user.role.trim() == "") {
        this.$message.error("The role should not be null.");
        return;
      }
      if (this.user.phone.trim() == "") {
        this.$message.error("The phone number should not be null.");
        return;
      }
      if (this.user.email.trim() == "") {
        this.$message.error("The email should not be null.");
        return;
      }
      this.dialogTitle = "Add user";
      this.request.post("/user", this.user).then((res) => {
        if (res.code === "200") {
          this.$message.success("Save successfully");
          this.dialogFormVisible = false;
          this.load();
        } else {
          this.$message.error(res.msg);
        }
      });
    },
    handleAdd() {
      this.dialogTitle = "Add user";
      this.dialogFormVisible = true;
      this.user = {
        username: "",
        nickname: "",
        newPassword: "",
        role: "",
        phone: "",
        email: "",
        address: "",
      };
    },
    //编辑
    handleEdit(row) {
      this.user = JSON.parse(JSON.stringify(row));
      this.dialogTitle = "Edit user";
      this.dialogFormVisible = true;
    },
    //删除
    handleDelete(id) {
      this.$confirm("Are you sure to delete the user?", "Warning", {
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        type: "warning",
      }).then(() => {
        this.request.delete("/user/" + id).then((res) => {
          if (res.code === "200") {
            this.$message({
              type: "success",
              message: "Delete successfully",
            });
            this.load();
          } else {
            this.$message.error(res.msg);
          }
        });
      });
    },
    //批量删除
    delBatch() {
      let ids = this.multipleSelection.map((v) => v.id);
      console.log(ids);
      this.$confirm("Are you sure to delete these users?", "Warning", {
        confirmButtonText: "Yes",
        cancelButtonText: "No",
        type: "warning",
      }).then(() => {
        this.request.post("/user/del/batch", ids).then((res) => {
          if (res.code === "200") {
            this.$message({
              type: "success",
              message: "Delete Successfully",
              duration: 3000,
            });
            this.load();
          } else {
            this.$message.error(res.msg);
          }
        });
      });
    },
  },
};
</script>

<style scoped>
</style>