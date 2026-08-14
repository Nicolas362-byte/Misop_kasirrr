/*====================================
    MENU.JS
====================================*/

// Pencarian Menu

const search=document.getElementById("searchMenu");

if(search){

search.addEventListener("keyup",function(){

let keyword=this.value.toLowerCase();

document.querySelectorAll("tbody tr").forEach(row=>{

let text=row.innerText.toLowerCase();

row.style.display=text.includes(keyword)?"":"none";

});

});

}

// Hover gambar

document.querySelectorAll("table img").forEach(img=>{

img.addEventListener("mouseenter",()=>{

img.style.transform="scale(1.15)";

img.style.transition=".3s";

});

img.addEventListener("mouseleave",()=>{

img.style.transform="scale(1)";

});

});

// Animasi tabel

document.querySelectorAll("tbody tr").forEach((row,index)=>{

row.style.opacity="0";

row.style.transform="translateY(15px)";

setTimeout(()=>{

row.style.transition=".4s";

row.style.opacity="1";

row.style.transform="translateY(0px)";

},index*70);

});

// AJAX Update Stok
document.querySelectorAll(".form-update-stok").forEach(form => {
    form.addEventListener("submit", function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const submitBtn = this.querySelector("button");
        submitBtn.style.pointerEvents = "none";
        
        fetch(this.action, {
            method: "POST",
            body: formData,
            headers: {
                "X-Requested-With": "XMLHttpRequest"
            }
        })
        .then(response => response.json())
        .then(data => {
            submitBtn.style.pointerEvents = "auto";
            if(data.status === "success") {
                const stokContainer = this.closest(".stok-container");
                const badge = stokContainer.querySelector(".stok-badge");
                const minusBtn = stokContainer.querySelector(".btn-stok-minus");
                
                badge.textContent = data.stok_formatted;
                badge.className = "badge stok-badge " + data.badge_class;
                
                badge.style.transform = "scale(1.25)";
                setTimeout(() => {
                    badge.style.transform = "scale(1)";
                }, 200);
                
                if(data.stok <= 0) {
                    minusBtn.disabled = true;
                } else {
                    minusBtn.disabled = false;
                }
            } else {
                alert(data.message || "Gagal mengupdate stok.");
            }
        })
        .catch(err => {
            submitBtn.style.pointerEvents = "auto";
            this.submit();
        });
    });
});

// Modal Tambah Menu Handler
const modal = document.getElementById("modalTambahMenu");
const btnTambah = document.getElementById("btnTambahMenu");
const btnClose = document.getElementById("closeModal");
const btnBatal = document.getElementById("btnBatalModal");

if(btnTambah && modal) {
    btnTambah.addEventListener("click", () => {
        modal.classList.add("show");
    });
}

function hideModal() {
    if(modal) {
        modal.classList.remove("show");
    }
}

if(btnClose) btnClose.addEventListener("click", hideModal);
if(btnBatal) btnBatal.addEventListener("click", hideModal);

window.addEventListener("click", (e) => {
    if(e.target === modal) {
        hideModal();
    }
});