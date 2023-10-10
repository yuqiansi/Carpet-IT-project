<template>
  <div>
    <div class="demo-input-size">
      <el-input placeholder="Please enter the file name: " prefix-icon="el-icon-a-042" style="width: 250px;padding-right: 5px" v-model="fileName"></el-input>
      <el-button type="primary" @click="search">
        <i class="el-icon-a-042" style="padding-right: 6px"></i>
        Search
      </el-button>
      <el-button type="danger" @click="reload">
        <i class="el-icon-a-031" style="padding-right: 6px"></i>
        Reset
      </el-button>

    </div>
    <!--          按钮栏-->
    <div style="padding-top: 10px">

      <el-upload action="http://localhost:9191/file/upload" :show-file-list="false" :on-success="handleFileUploadSuccess" style="display: inline-block">
        <el-button type="primary" style="font-size: 18px;"><i class="el-icon-a-032" style="padding-right: 6px；font-size: 22px;"></i>Upload</el-button>
      </el-upload>
      <el-button type="danger" @click="delBatch" style="margin-left: 10px;font-size: 18px;"><i class="el-icon-a-022" style="padding-right: 6px;font-size: 22px;"></i>Bulk Deletion</el-button>
    </div>
    <!--          表格-->
    <el-table :data="tableData" background-color="black" @selection-change="handleSelectionChange" >
      <el-table-column type="selection" ></el-table-column>
      <el-table-column prop="name" label="File Name" width="350" ></el-table-column>
      <el-table-column prop="type" label="File Type" width="180" ></el-table-column>
      <el-table-column prop="size" label="File Size" width="180" ></el-table-column>
      <el-table-column label="Operation" width="240" fixed="right">
        <template slot-scope="scope">

<!--          下载-->
          <a :href="baseApi + scope.row.url">
            <el-button
              type="success"
              style="font-size: 18px;"
              >
              <i class="el-icon-a-061" stye="font-size: 26px;"></i>
              Download
            </el-button>
          </a>
<!--          删除-->
          <el-button
              type="danger"
              style="margin-left: 10px;font-size: 18px;"
              @click="handleDelete(scope.row.id)">
              <i class="el-icon-a-022" style="font-size: 22px;"></i>
              Delete
            </el-button>
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
export default {
  name: "File",
  created() {
    this.load();
  },
  data(){
    return{
      baseApi: this.$store.state.baseApi,
      tableData: [],
      total: 0,
      pageSize: 5,
      currentPage: 1,
      fileName: '',

      multipleSelection: []
    }
  },
  methods:{
    handleSizeChange(pageSize){
      this.pageSize = pageSize;
      this.load();
    },
    handleCurrentPage(currentPage){
      this.currentPage = currentPage;
      this.load();
    },
    handleSelectionChange(val){
      this.multipleSelection = val
    },
    handleFileUploadSuccess() {
      this.$message.success("Upload Successfully");
      this.load();
    },
    handleEnable(row){
      this.request.get("/file/enable",{params:{"id": row.id, "enable": row.enable}}).then(res=>{
        if(res.code==='200'){
          this.$message({
            type: "success",
            message: "Edit Successfully",
            duration: 3000
          });
          this.load();
        }else {
          this.$message.error(res.msg);
        }
      })
    },
    load(){
      this.request.get("/file/page",{
        params:{
          pageNum: this.currentPage,
          pageSize: this.pageSize,
          fileName: this.fileName,
        }
      }).then(res=>{
            if(res.code==='200'){
              this.tableData = res.data.records;
              for(let s of this.tableData){
                let size = s.size;
                if(size<1024){
                  s.size = size+' Kb';
                }else if(size >1024 && size < 1024*1024){
                  s.size = (size / 1024).toFixed(2) +' Mb'
                }else{
                  s.size = size /1024/1024 .toFixed(2)+' Gb'
                }
              }
              this.total = res.data.total;
            }
          }
      )
    },
    search(){
      this.currentPage = 1;
      this.load();
    },
    reload(){
      this.fileName='';
      this.load()
    },
    // //编辑
    // handleEdit(row){
    //   this.user = JSON.parse(JSON.stringify(row));
    //   this.dialogTitle='Edit User';
    //   this.dialogFormVisible = true;
    // },

    //删除
    handleDelete(id){
      this.$confirm('Are you sure to delete this file?', 'Warning', {
        confirmButtonText: 'yes',
        cancelButtonText: 'no',
        type: 'warning'
      }).then(() => {
        this.request.delete("/file/"+id).then(res=>{
          if(res.code==='200'){
            this.$message({
              type: "success",
              message: "Delete Successfully",
              duration: 3000
            });
            this.load();
          }else {
            this.$message.error(res.msg);
          }
        })
      })
    },
    //批量删除
    delBatch(){
      let ids = this.multipleSelection.map(v => v.id);
      this.$confirm('Are you sure to delete these users?', 'Warning', {
        confirmButtonText: 'yes',
        cancelButtonText: 'no',
        type: 'warning'
      }).then(() => {
        this.request.post("/file/del/batch",ids).then(res=>{
          if(res.code==='200'){
            this.$message({
              type: "success",
              message: "Delete successfully",
              duration: 3000
            });
            this.load();
          }else {
            this.$message.error(res.msg);
          }
        })

      })

    }
  },
}
</script>

<style scoped>

</style>